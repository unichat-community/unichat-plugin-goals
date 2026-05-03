# UniChat Plugin - Goals System

[🇺🇸 English](./README.md) | [🇧🇷 Português](./README.pt-br.md)

Este plugin do [UniChat](https://unichat.voguh.me) implementa um sistema de metas para sponsorship e donates, permitindo que os streamers configurem metas e acompanhem o progresso em direção a elas.

Roadmap:
- [-] Implementar o acompanhamento da meta de donate.
  - [x] Implementar a escuta de doações e o acompanhamento do progresso.
  - [x] Implementar o comando `!goal set donate <amount>` para definir o valor da meta de donate.
  - [x] Implementar o comando `!goal add donate <amount>` para adicionar progresso à meta de donate.
  - [x] Implementar o comando `!goal remove donate <amount>` para remover progresso da meta de donate.
  - [x] Implementar o comando `!goal reset donate` para redefinir o progresso da meta de donate.
  - [ ] Implementar conversão de moeda para metas de donate (talvez usando a [Frankfurter API](https://frankfurter.dev/)).
- [ ] Implementar o acompanhamento da meta de sponsorship.
  - [ ] Implementar a escuta de sponsorship e o acompanhamento do progresso.
  - [ ] Implementar o comando `!goal set sponsor <amount>` para definir o valor da meta de sponsorship.
  - [ ] Implementar o comando `!goal add sponsor <amount>` para adicionar progresso à meta de sponsorship.
  - [ ] Implementar o comando `!goal remove sponsor <amount>` para remover progresso da meta de sponsorship.
  - [ ] Implementar o comando `!goal reset sponsor` para redefinir o progresso da meta de sponsorship.
- [ ] Implementar o acompanhamento da meta de sponsorship gift.
  - [ ] Implementar a escuta de sponsorship gift e o acompanhamento do progresso.
  - [ ] Implementar o comando `!goal set sponsor_gift <amount>` para definir o valor da meta de sponsorship gift.
  - [ ] Implementar o comando `!goal add sponsor_gift <amount>` para adicionar progresso à meta de sponsorship gift.
  - [ ] Implementar o comando `!goal remove sponsor_gift <amount>` para remover progresso da meta de sponsorship gift.
  - [ ] Implementar o comando `!goal reset sponsor_gift` para redefinir o progresso da meta de sponsorship gift.

---

### Licença

Este projeto está licenciado sob a [Eclipse Public License, Version 2.0](./LICENSE).
