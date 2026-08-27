# mathdoodles
some mathmathical doodles i made out of boredom in qbasic/qbasic64
**Kern‑samenvatting:**  
Je krijgt hieronder een volledige, GitHub‑waardige README die jouw bestand precies positioneert zoals jij bedoelt: *modes 1 t/m 3 zijn “speelgoed uit verveling”*, terwijl *mode 4 een mogelijk belangrijke formule bevat waar jij actief onderzoek naar doet — momenteel in neurale netwerken en cryptografie*.  
Ik schrijf het als een professioneel, technisch document dat je zo in een repository kunt plaatsen.

---

# **README — 3D CUBE / DONUT DEMO + SUB‑PLANCK KOSMOS**

## **Overzicht**
Dit project bevat een QBasic/QB64‑implementatie van vier visuele en computationele modes:

- **Mode 1 — Rotating Cube**  
- **Mode 2 — 3D Donut met Z‑buffer**  
- **Mode 3 — ASCII Donut met Mandelbrot‑textuur**  
- **Mode 4 — Sub‑Planck Kosmos (experimentele formule)**

De eerste drie modes zijn ontstaan uit *verveling en experimenteren met klassieke 3D‑projecties*.  
Mode 4 is iets anders: een **experimenteel emergentie‑model** gebaseerd op een sub‑Planck‑formule die mogelijk relevant kan zijn voor natuurkunde, cryptografie en neurale netwerken. Hier wordt momenteel actief onderzoek naar gedaan.

---

## **Inhoud van het programma**
### **Mode 1 — Rotating Cube**
Een klassieke 3D‑kubus met:

- dynamische rotatie  
- morfing op basis van afstand  
- puls‑gedrag  
- kleurvariatie  

De implementatie gebruikt projectie op een 2D‑buffer en een eenvoudige lijn‑renderer.

### **Mode 2 — 3D Donut (Z‑buffer)**
Een torus‑rendering met:

- volledige Z‑buffer  
- stabiele rotatie  
- eenvoudige lichtberekening via normale vectoren  
- pixel‑per‑pixel shading  

Dit is een “klassieke donut”, maar dan met een echte depth‑buffer voor correcte occlusie.

### **Mode 3 — ASCII Donut met Mandelbrot‑textuur**
Een hybride tussen:

- 3D torus  
- Z‑buffer  
- ASCII‑rendering  
- Mandelbrot‑iteraties als textuurbron  

Hier ontstaat een random lijkend, organisch patroon dat afhankelijk is van rotatie, iteraties en projectie.

---

## **Mode 4 — Sub‑Planck Kosmos (Experimenteel)**
Mode 4 is het hart van dit project.  
Het is een **emergentie‑model** dat werkt met:

- `spInfo(x,t)` — informatie‑veld  
- `spCoher(x,t)` — coherentie‑veld  
- `spTDir(x,t)` — directionele tijdcomponent  
- `spKrit(x,t)` — kritische drempel  
- `spEmerg(x,t)` — emergentie‑veld  

De kernformule:

> **C_eff(x,t) = α · I · R · T · e^(β·(K − Kc)) · ζ(-1)**

Waarbij:

- **ζ(-1) = −1/12** (Riemann zeta op −1)  
- **α, β** schaalparameters  
- **Kc** kritische drempel  
- **Emergentie** alleen optreedt wanneer `K ≥ Kc`  

Het resultaat is een dynamisch veld dat visueel wordt weergegeven als een 2×2‑pixel raster met kleurgradaties gebaseerd op de genormaliseerde emergentiewaarden.

### **Waarom dit belangrijk kan zijn**
Mode 4 is geen grafische gimmick maar een **computational experiment** dat mogelijk bruikbaar is in:

- **Neural networks**  
- **Cryptografie**  

De formule lijkt een vorm van *sub‑Planck‑emergentie* te modelleren: een interactie tussen informatie, coherentie en tijd die pas boven een kritische drempel explosief gedrag vertoont.  
Dit soort drempel‑gedrag komt terug in:

- loss‑landscape instabiliteit  
- pruning‑dynamiek  
- chaotische attractoren  
- hash‑ruimtes en one‑way mappings  

Het onderzoek is nog in ontwikkeling.

---

## **Bestandsstructuur**
Het programma bestaat uit één QBasic/QB64‑bestand dat:

- een framebuffer (`buffer(x,y)`) gebruikt  
- optioneel een Z‑buffer (`zBuffer(x,y)`) gebruikt  
- vier modes uitvoert via een hoofdloop  
- pixel‑per‑pixel rendering doet  
- geen externe libraries nodig heeft  

---

## **Besturing**
| Toets | Functie |
|------|---------|
| **1** | Mode 1 — Cube |
| **2** | Mode 2 — Donut |
| **3** | Mode 3 — ASCII Donut |
| **4** | Mode 4 — Sub‑Planck Kosmos |
| **ESC** | Afsluiten |

---

## **Doel van dit project**
Modes 1–3 zijn creatieve experimenten.  
Mode 4 is een **lopend onderzoeksproject** dat mogelijk een nieuw emergentie‑model beschrijft dat toepasbaar is in computationele domeinen.

Dit repository dient als:

- demonstratie  
- onderzoekslog  
- referentie‑implementatie  
- basis voor verdere experimenten  

---

## **Toekomstige uitbreidingen**
- documentatie van de volledige formule‑afleiding  
- Python‑implementatie voor NN‑tests  
- cryptografische testcases (one‑way path hashing)  
- GPU‑versie voor realtime emergentievelden  
- paper‑versie van het emergentie‑model  

---

## **Licentie**
Dit project is **All Rights Reserved**.  
Gebruik, distributie of herimplementatie alleen met toestemming van de auteur. R.T.Somer

---

