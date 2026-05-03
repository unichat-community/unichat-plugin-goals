# UniChat Plugin - Goals System

[🇺🇸 English](./README.md) | [🇧🇷 Português](./README.pt-br.md)

This [UniChat](https://unichat.voguh.me) plugin implements a goals system for sponsorships and donations, allowing streamers to set up goals and track progress towards them.

Roadmap:
- [-] Implement donate goal tracking.
  - [x] Implement donate listening and progress tracking.
  - [x] Implement `!goal set donate <amount>` command to set a donate goal target amount.
  - [x] Implement `!goal add donate <amount>` command to add progress towards the donate goal.
  - [x] Implement `!goal remove donate <amount>` command to remove progress towards the donate goal.
  - [x] Implement `!goal reset donate` command to reset the donate goal progress.
  - [ ] Implement currency conversion for donate goals (Maybe using [Frankfurter API](https://frankfurter.dev/)).
- [ ] Implement sponsorship goal tracking.
  - [ ] Implement sponsorship listening and progress tracking.
  - [ ] Implement `!goal set sponsor <amount>` command to set a sponsorship goal target amount.
  - [ ] Implement `!goal add sponsor <amount>` command to add progress towards the sponsorship goal.
  - [ ] Implement `!goal remove sponsor <amount>` command to remove progress towards the sponsorship goal.
  - [ ] Implement `!goal reset sponsor` command to reset the sponsorship goal progress.
- [ ] Implement sponsorship gift goal tracking.
  - [ ] Implement sponsorship gift listening and progress tracking.
  - [ ] Implement `!goal set sponsor_gift <amount>` command to set a sponsorship gift goal target amount.
  - [ ] Implement `!goal add sponsor_gift <amount>` command to add progress towards the sponsorship gift goal.
  - [ ] Implement `!goal remove sponsor_gift <amount>` command to remove progress towards the sponsorship gift goal.
  - [ ] Implement `!goal reset sponsor_gift` command to reset the sponsorship gift goal progress.

---

### License

This project is licensed under the [Eclipse Public License, Version 2.0](./LICENSE).
