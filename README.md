\# Memory Catcher (MVP)

> **專案狀態：Prototype / Proof of Concept**
> 本專案採用 **Google Antigravity (Agent-first IDE)** 協作開發，旨在驗證「回溯式錄音」系統架構與資料流邏輯。

## 📖 專案簡介
Memory Catcher 解決使用者「漏聽重要資訊」的痛點，透過 Ring Buffer 概念實作回溯錄音。本原型重點在於驗證系統架構可行性，而非商業發布。

## 🛠 技術與開發模式
- **開發環境：** Google Antigravity (Agent-first IDE)
- **前端框架：** Flutter (Dart)
- **架構設計：** 採用前後端分離，透過 Agent 輔助繪製 Sequence Diagram 並生成基礎邏輯。

## ⚠️ Known Issues (開發限制)
1. **Ring Buffer 優化：** 目前記憶體管理尚未針對長時間錄音最佳化。
2. **背景執行：** 受限於作業系統權限，目前僅支援前景執行。
3. **資安隱私：** API 傳輸加密為未來優化目標。

---
*Created by 宋靜涵 (應用於淡江大學資管系轉學考審查資料)*\
