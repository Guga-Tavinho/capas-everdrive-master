# Atualização de Firmware do EverDrive de Master System que possibilita a inclusão de capas nos jogos.

Firmware modificado para o EverDrive de Master System que adiciona suporte à exibição de capas dos jogos diretamente no menu do cartucho.

# Sobre o Projeto

A ideia deste projeto nasceu após acompanhar o trabalho do Ludufre, que conseguiu implementar a exibição de capas no EverDrive de SNES. Como o Master System é meu console favorito e gosto muito de navegar pela biblioteca de jogos através do EverDrive, surgiu a vontade de trazer uma funcionalidade semelhante para a plataforma.

Inicialmente, existia uma grande preocupação em não danificar o cartucho durante o desenvolvimento. Por isso, todos os testes foram realizados executando versões experimentais do firmware como se fossem jogos comuns, sem gravar nada permanentemente na memória ROM do EverDrive. Somente após extensivos testes e validações a modificação foi finalmente incorporada ao sistema.

Durante o desenvolvimento, diversas limitações de hardware precisaram ser superadas. O Master System possui recursos bastante restritos, especialmente em relação à quantidade de memória disponível e ao número de cores que podem ser exibidas simultaneamente. Para viabilizar o suporte às capas, foi necessário redesenhar parte da interface gráfica do sistema, otimizando o uso de tiles e preservando o máximo possível dos recursos gráficos para a exibição das imagens.

## Como Funciona

O funcionamento é simples:

1. Escolha uma imagem no formato `.png`.
2. Utilize o conversor incluído neste projeto para transformá-la em um arquivo `.cov`.
3. Copie o arquivo `.cov` para a mesma pasta da ROM correspondente no cartão SD.
4. O arquivo da capa deve possuir exatamente o mesmo nome da ROM.
5. Copie o arquivo `MSOS.mso` para a raiz do cartão SD.
6. Execute-o para atualizar o sistema operacional do EverDrive.

Após a atualização, as capas passarão a ser exibidas automaticamente durante a navegação pelos jogos.

O pacote também inclui tutoriais ilustrados para auxiliar na instalação e utilização do recurso.

## Limitações Conhecidas

Devido às limitações de hardware do Master System e do EverDrive, algumas restrições precisam ser observadas:

- Cada diretório suporta no máximo **128 capas**.
- Um número excessivo de jogos em uma mesma pasta pode causar lentidão na navegação.
- Nos testes realizados, o melhor equilíbrio entre organização e desempenho foi obtido com aproximadamente **54 jogos por diretório**.

## Recursos

- Exibição de capas (box art) dos jogos.
- Tradução de todo o EverDrive para PT-BR.
- Compatível com o EverDrive de Master System chines ou original Krikzz.

# Tutorial de atualização da firmware e inclusão das capas:

<img width="1408" height="768" alt="Tutorial" src="https://github.com/user-attachments/assets/8c1bdbc5-1952-4306-8fe5-fcb948467a16" />


# Tutorial de utilização do conversor de capas:

<img width="1408" height="768" alt="Tutorial" src="https://github.com/user-attachments/assets/392dace8-8362-4f09-8b35-6f8e12d88e6a" />


# Tutorial de utilização do FatSorter:

<img width="1408" height="768" alt="Tutorial" src="https://github.com/user-attachments/assets/10adbaec-d93a-42e1-b9e6-736b1e540342" />

# Créditos

### Tavinho.games

- Instagram: https://www.instagram.com/tavinho.games

# Agradecimentos

### thalescamara
- YouTube: https://www.youtube.com/@thalescamara

### Ludufre
