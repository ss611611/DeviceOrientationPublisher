## 前言
- 本影片介紹了 Swift 的 **Combine 框架**，重點討論了如何創建 Publisher、Subscriber，並探討生命週期與錯誤處理。Combine 框架是處理響應式編程的重要工具，讓我們能夠輕鬆地管理資料流與事件處理。

## Publisher 與 Subscriber 的基礎

### 創建 Publisher
- **Publisher** 是 Combine 框架中的核心概念，負責發布事件或數據流。我們可以使用多種不同類型的 Publisher，如 `Just` 和 `Sequence` Publisher。
  - **Just Publisher**：只發布單一的值，例如：
    ```swift
    let publisher = Just("Hello World")
    ```
    這個 Publisher 發布一個字串，然後結束訂閱。
  - **Sequence Publisher**：可以用於發布一系列數值，例如一個陣列。
    ```swift
    let numbersPublisher = [1, 2, 3].publisher
    ```

### 訂閱 Publisher
- 要使用 Publisher，我們必須訂閱（subscribe）它。這可以通過 `sink` 方法來實現，並用來接收發布的值：
  ```swift
  publisher.sink { value in
      print(value)
  }
  ```
- **取消訂閱**：`sink` 方法會返回一個 `AnyCancellable` 物件，這表示訂閱持續有效，直到被手動取消或作用域結束為止。

## Publisher 的進階操作

### 組合操作與數據轉換
- **map**：將發布的數據進行轉換。使用 `map` 對數據進行操作，例如將數字加倍：
  ```swift
  numbersPublisher.map { $0 * 2 }
  ```

### 自動連接與定時操作
- **Timer Publisher**：可以使用內建的 `Timer` 來每秒發布一個事件。例如，設置一個每秒發布時間戳的 Publisher：
  ```swift
  let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  ```

### 訂閱不同來源的事件
- Combine 支援來自其他系統組件的事件，例如 `NotificationCenter` 或 `UIDevice` 的方向變化事件。這讓我們能夠輕鬆地監控系統事件並更新應用。

## 錯誤處理與完成處理

### 錯誤處理
- 在進行數據流操作時，有時可能會發生錯誤，例如在 `tryMap` 操作中。我們可以使用 `catch` 來捕捉錯誤並返回替代數據流。
  ```swift
  numbersPublisher
      .tryMap { number in
          if number == 4 { throw NumberError.operationFailed }
          return number * 2
      }
      .catch { error in Just(0) }  // 捕捉錯誤並返回 0
  ```

### 完成處理
- **完成事件**：當 Publisher 結束發布時，我們可以使用 `sink` 的 `completion` 來處理完成事件或錯誤。
  ```swift
  .sink(receiveCompletion: { completion in
      switch completion {
      case .finished:
          print("Finished")
      case .failure(let error):
          print("Error: \(error)")
      }
  }, receiveValue: { value in
      print("Received value: \(value)")
  })
  ```

### 重點整理
- **Publisher 創建**：使用 `Just` 或 `Sequence` Publisher 來發布單一或一系列數據。
- **訂閱與取消訂閱**：使用 `sink` 訂閱 Publisher，並通過 `AnyCancellable` 控制訂閱的生命週期。
- **進階操作**：使用 `map` 和 `tryMap` 等操作對數據進行轉換與處理。
- **錯誤與完成處理**：使用 `catch` 捕捉錯誤，並通過 `completion` 處理完成事件。
