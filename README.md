# Who will leave next?

**A retention problem, solved with customer data.**

Churn is quiet until the revenue shows it. I help marketing and CRM teams see **who is about to leave** — early enough to do something — instead of paying full price to win people back later.

---

## The stake

Acquiring a customer costs more than keeping one. If a meaningful slice of your base is drifting away every quarter, you are funding growth with a leaky bucket. The question is not “do we have churn?” It is **“who should we talk to this month?”**

## The story

A card portfolio has **10,127 customers** and a retention team that cannot call everyone. Who is most likely to still be a customer — and who is already halfway out the door?

I compared models the way a business actually chooses a tool: start simple, then see what ensembles buy you. On the same data:

- A **single decision tree** is explainable but leaves lift on the table
- **Random forest** closes most of the gap
- **Tuned XGBoost** wins on every metric that matters for a save team

**Outcome on this build:**
- Best model ranks leavers very cleanly (**AUC ~0.99** on holdout)
- **Transaction behaviour** (`total_trans_amt`) is the strongest signal — not demographics alone
- Retention gets a **ranked save list**, not another monthly report

> **The commercial idea:** spend save offers on the riskiest valuable customers first. Same budget. Fewer goodbyes.

---

## What that looks like in your world

| You have | I turn it into |
|----------|----------------|
| Customer, tenure, and behaviour tables | A **churn risk score** per customer |
| A save budget / retention offer | A **ranked outreach list** |
| “Some segment feels sticky” | Model evidence: **what actually predicts leaving** |
| Mixed tooling opinions in the room | A **head-to-head comparison** you can defend |

**Typical engagement:** define the churn window and save play → build scores on your data → hand over the list, the rules, and a lift plan (holdout included).

**[Talk to me about retention →](https://datafying.co/#contactus)** · [datafying](https://datafying.co/)

---

## Why marketing & CRM leaders bring me in

- I frame the job as **who to save**, not “which algorithm wins Kaggle”
- I show **what you give up** when you choose a simpler model (so you can own explainability vs lift)
- Technical detail is there for your data team — commercial story is there for you
- You leave with something that runs next cycle

---

## Proof of craft *(technical — full depth)*

### Business question
Which customers will still be `still_customer` — and which model finds them best?

### Method (progressive comparison on one dataset)

| Step | Script | What it tests |
|------|--------|----------------|
| 1 | `01-dtree-churn.R` | Single decision tree — explainable baseline |
| 2 | `02-dtree-tuned.R` | Tuning + 3-fold CV — how much does tuning buy? |
| 3 | `03-xgboost.R` | XGBoost + 5-fold CV |
| 4 | `04-bagged-trees.R` | Bagging — middle ground |
| 5 | `05-model-comparison.R` | Tree vs Random Forest vs XGBoost |

### Results (holdout / CV comparison)

| Model | Accuracy | Precision | Recall | F1 | AUC | Log loss |
|-------|----------|-----------|--------|-----|-----|----------|
| Decision Tree | 0.934 | 0.960 | 0.961 | 0.961 | 0.935 | 0.233 |
| Random Forest | 0.960 | 0.962 | 0.991 | 0.976 | 0.989 | 0.123 |
| **XGBoost** | **0.966** | **0.972** | **0.989** | **0.980** | **0.990** | **0.100** |

**What this means for a save team**
- XGBoost wins every metric that matters when **missing a leaver is expensive**
- Tuning a single tree helps a little; **ensembles help a lot**
- Cross-validation beats one lucky split before you put this in a CRM

**Signals that predicted churn**
- **`total_trans_amt`** — recent transaction behaviour dominates
- Demographics matter less than **activity and credit behaviour** in this data
- Useful for creative and offer design: *save plays should watch spending drop-off*

### How this ships
1. Score the base on a schedule (monthly / pre-campaign)
2. Export **top risk × valuable** segment to CRM / CSM queue
3. Trigger save offer / human outreach
4. Hold out a control to **prove retention lift**, not just model scores

### Limits
- Definition of churn and observation window must match your business
- Scores drift as products and pricing change — refresh cadence matters
- A model prioritises who to call; **the save offer still has to be worth taking**

---

## Reproduce the build

```bash
git clone https://github.com/47096/customer-churn.git
cd customer-churn
```

```r
source("setup.R")                # installs dependencies
source("05-model-comparison.R")  # final comparison
```

**Data:** [Bank Churners on Kaggle](https://www.kaggle.com/sakshigoyal7/credit-card-customers) — 10,127 customers, 19 features (demographics, account, transactions, credit behaviour). Target: `still_customer`.

**Stack:** `tidymodels` · `rpart` · `ranger` · `xgboost` · `vip` · `rpart.plot`

---

## Next step

If customers are slipping and your team cannot say **who to save first**, that is the engagement I run.

**[Book a conversation →](https://datafying.co/#contactus)** · Customer analytics for retention · [datafying](https://datafying.co/)
