import Carbon
import Foundation

func main() -> Int32 {
  let arguments = CommandLine.arguments

  // 如果提供了参数,则切换到指定的输入法
  if arguments.count > 1 {
    let inputSourceID = arguments[1]
    return switchInputSource(to: inputSourceID)
  } else {
    // 否则,获取并打印当前输入法
    if let currentSourceID = getCurrentInputSource() {
      print(currentSourceID)
      return 0
    } else {
      return 1
    }
  }
}

/// 获取当前输入法的 ID
func getCurrentInputSource() -> String? {
  guard let currentInputSource = TISCopyCurrentKeyboardInputSource()?.takeRetainedValue() else {
    return nil
  }

  guard let sourceID = TISGetInputSourceProperty(currentInputSource, kTISPropertyInputSourceID) else {
    return nil
  }

  return Unmanaged<CFString>.fromOpaque(sourceID)
    .takeUnretainedValue() as String
}

/// 切换到指定的输入法
func switchInputSource(to inputSourceID: String) -> Int32 {
  let filter = [kTISPropertyInputSourceID: inputSourceID] as CFDictionary

  guard let keyboards = TISCreateInputSourceList(filter, false)?.takeRetainedValue() else {
    return 1
  }

  guard CFArrayGetCount(keyboards) > 0 else {
    return 1
  }

  let selectedSource = unsafeBitCast(
    CFArrayGetValueAtIndex(keyboards, 0),
    to: TISInputSource.self
  )

  return TISSelectInputSource(selectedSource)
}

// 执行主函数
exit(main())
