# Game Design Document (GDD) — Delay The Inevitable

## 1. Executive Summary & Vision
- **Nome del Progetto:** *Delay The Inevitable*
- **Genere:** Fast-paced Procedural Survival / Task-Action Top-Down
- **Ispirazioni:** *Grace* (Roblox), giochi ad alta velocità e reattività, estetica Meta/Creepypasta.
- **Pitch:** Il giocatore esegue un misterioso file `.exe` che funge da interfaccia neurale con le anime di persone sull'orlo della morte per crisi psicologiche o morali. L'obiettivo è muoversi velocemente all'interno della loro mente, completare task per stabilizzare la psiche ed evitare entità letali il più a lungo possibile. La morte è inevitabile; conta solo quanto a lungo si riesce a ritardarla.

---

## 2. Narrative & Atmospheric Setting

### 2.1 La Premessa Meta-In-Game
L'interfaccia di gioco è presentata come un programma software misterioso e clandestino (`.exe`). L'operatore (il giocatore) si connette alla coscienza di individui in bilico tra la vita e la morte non per cause fisiche dirette (es. incidenti), ma per travagli mentali e morali.

### 2.2 Il Taunter (Lo Sfottò post-Morte)
Ad ogni fallimento (morte del paziente), compare una schermata con un dialogo di un misterioso personaggio/interfaccia che commenta l'esito:
- Prende in giro il giocatore per aver creduto di poter salvare l'anima.
- Critica le performance di gioco (es. "Sei durato meno di un minuto", "Task ignorate").

---

## 3. Core Gameplay Loop

```mermaid
flowchart TD
    A[Entra nel "Cervello" - Mappa Procedurale]
    B --> C[Movimento Rapido & Completamento Task]
    C --> D[Schiva Entità Dinamiche]
    D -->|Sopravvivi| C
    D -->|Morte Inevitabile| E[Schermata Finale & Dialogo Sfottò]
    E --> F[Calcolo Crediti basato sul Tempo]
    F --> G[Shop: Acquisto Upgrade & Abilità]
    G --> A
```

2. **Infiltrazione Neurale:** Il giocatore controlla l'anima all'interno della mappa procedurale del cervello.
3. **Fase di Sopravvivenza (Fast-Paced):**
   - Movimento veloce, schivate ed esecuzione di task rapide.
   - Gestione dello spawn/despawn dinamico delle entità.
4. **Collasso (Morte):** Incontro con lo sfottò narrativo.
5. **Progressione Meta:** Conversione del tempo di sopravvivenza in crediti per potenziare l'anima.

---

## 4. Mechanics & Gameplay Systems

### 4.1 Il Giocatore (L'Anima)
- **Movimento:** Estremamente veloce, reattivo e dinamico (dash, inerzia, rimbalzo sui muri).
- **Abilità Attive:** Sbloccabili nello shop con i crediti 

### 4.2 La Mappa ("Il Cervello")
- Generata proceduralmente ad ogni run (grafo a corridoi/stanze).
- Disseminata di punti di interazione (**Task Node**).

### 4.3 Il Sistema delle Task
- **Scopo:** Mantenere stabile la barra della sanità/vita del paziente per prolungare la run.
- **Tipologia:** Mini-game estremamente rapidi (1-3 secondi) da eseguire in movimento per non rimanere fermi ed essere catturati dalle entità.

---

## 5. Il Sistema delle Entità ("I Peccati")

### 5.1 Spawn & Despawn Dinamico
- Le entità non sono tutte presenti contemporaneamente sulla mappa fin dall'inizio.
- Spawnano e despawnano a intervalli temporali regolari o in base al livello di panico del cervello, costringendo il giocatore a cambiare continuamente rotta.

### 5.2 Sistema di Buff "Peccato del Paziente"
Tutti i tipi di entità possono comparire in qualsiasi run, ma **l'entità legata alla condizione specifica del paziente riceve un buff significativo**:


---

## 6. Economy & Meta-Progression

- **Valuta:** Crediti Neurali (calcolati in base ai secondi/minuti di sopravvivenza e alle task completate).
- **Shop / Upgrade System:**
  - **Statistiche Base:** Velocità di movimento, accelerazione, resistenza ai colpi.
  - **Abilità Attive:** Cooldown ridotti per abilità speciali.
  - **Aiuti di Gioco:** Scanner per le task, segnalatori di spawn per le entità.

---

## 7. User Interface (UI) & Visual Style

### 7.1 Architettura Multi-Finestra (OS / Software Simulator)
L'interfaccia di gioco rifiuta l'HUD tradizionale a schermo intero. Essendo presentata come un software `.exe`, la schermata è composta da **molteplici finestre indipendenti stile sistema operativo** disposte sul desktop dell'operatore: (ESEMPI!)
- **Finestra Gameplay Main:** Mostra la vista top-down dell'anima e del cervello in tempo reale.
- **Finestra Timer Task:** Un widget separato con i tempi limite per le quest attive e lo stato della sanità.
- **Finestra Status / Debuff:** Mostra la condizione mentale del paziente, le trappole attive e i debuff correnti.
- **Finestra Abilità & Cooldown:** Un pannello dedicato alle skill in possesso dell'anima e i relativi tempi di ricarica.
- **Finestra Logger / Taunter:** Terminale di testo dove il personaggio misterioso invia messaggi o sbeffeggia l'operatore.

---


### 8.1 Visual & Art Style (Ultra-Minimalist)
- **Stile Visivo:** Ultra-minimalista, pulito ed essenziale (forme geometriche semplici, linee definite, sprite simbolici).
- **Lettura ad Alta Velocità:** L'uso di figure geometriche base (cerchi per l'anima, quadrati/poligoni per i nodi, forme spigolose per le entità) garantisce massima chiarezza visiva ed eleganza senza richiedere illustrazioni o asset complessi.
- **Palette Colori:** Alto contrasto (es. sfondi scuri stile terminale/vector graphics con dettagli al neon o monocromatici) per identificare subito insidie e task durante il movimento rapido.

### 8.2 Audio Direction
*Section Incomplete / Work in Progress*
- [ ] Definire lo stile sonoro per le entità (effetti audio/distorsioni).
- [ ] Scegliere il genere musicale di sottofondo (es. Synthwave, Breakcore, Ambient/Distorted).
- [ ] Definire i feedback audio per completamento task e sfottò.

