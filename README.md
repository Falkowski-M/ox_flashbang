# ox_flashbang – Advanced Flashbang System for FiveM

![Lua](https://img.shields.io/badge/language-Lua-blue)
![Platform](https://img.shields.io/badge/platform-FiveM-orange)
![Framework](https://img.shields.io/badge/compatible-ox__inventory%20%7C%20ox__lib-green)

## 📌 O projekcie
`ox_flashbang` to zaawansowany skrypt granatu hukowego (flashbang) stworzony dla serwerów FiveM. Został zaprojektowany z myślą o realizmie i wysokiej wydajności, oferując pełną synchronizację między graczami oraz zaawansowane efekty wizualne i dźwiękowe.

**Projekt demonstruje umiejętność pracy z:**
* Native'ami GTA V w środowisku FiveM.
* Synchronizacją zdarzeń Server-to-Client.
* Interfejsem użytkownika (NUI) w celu wywołania efektów oślepienia.
* Integracją z ekosystemem `ox` (inventory/lib).

## 🚀 Główne Funkcjonalności
* **Realistyczny Efekt Oślepienia:** Wykorzystanie dedykowanego overlay'a HTML oraz efektów `Timecycle` do symulacji utraty wzroku.
* **Efekty Dźwiękowe (Tinnitus):** Implementacja dźwięku wysokiej częstotliwości po wybuchu, który dynamicznie wycisza otoczenie.
* **Detekcja Spojrzenia:** System sprawdza, czy gracz patrzy w stronę wybuchu – jeśli się odwróci, efekt oślepienia jest znacznie słabszy lub nie występuje.
* **Synchronizacja Network:** Wykorzystanie `State Bags` lub `TriggerClientEvent` do płynnego informowania wszystkich pobliskich graczy o detonacji.
* **Wsparcie dla ox_inventory:** Skrypt jest przygotowany pod łatwą konfigurację jako przedmiot użytkowy (item use).

## 🛠️ Technologie
* **Lua:** Logika po stronie klienta i serwera.
* **NUI (HTML/CSS):** Obsługa białego ekranu (oślepienia) z efektem zanikania.
* **GTA V Particle Effects:** Synchronizowane efekty dymu i błysku w miejscu wybuchu.

## ⚙️ Instalacja
1. Pobierz repozytorium.
2. Wrzuć folder `ox_flashbang` do katalogu `resources`.
3. Dodaj `ensure ox_flashbang` do pliku `server.cfg`.
4. Skonfiguruj przedmiot w `ox_inventory/data/items.lua` (instrukcja wewnątrz skryptu).

## ⚠️ Disclaimer
Projekt stworzony w celach edukacyjnych oraz jako wkład w rozwój społeczności FiveM. Kod jest zoptymalizowany pod kątem niskiego zużycia zasobów (Low Resmon).

---
*Created by [Falkowski-M](https://github.com/Falkowski-M)*
