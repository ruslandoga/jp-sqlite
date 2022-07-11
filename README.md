This repo contains scripts to build japanese-english dictionaries stored in SQLite. The databases can be downloaded from "releases" page. Each database contains a single dictionary of the same name.

### `jmdict.db`

```sql
sqlite> .schema
-- entries.entry is json representation of jmdict's xml:entry
CREATE TABLE entries(id integer primary key, entry text not null) without rowid, strict;
-- lookup table is used to index entry.k_ele.keb | entry.r_ele.reb
CREATE TABLE lookup(expression text not null, id integer not null) strict;
CREATE INDEX lookup_idx on lookup(expression);

-- example queries
sqlite> select l.expression, e.entry from lookup l inner join entries e on e.id = l.id where l.expression = '四';
```

<table>
  <tr>
    <td> expression </td>
    <td> entry </td>
  </tr>
  <tr>
    <td> 四 </td>
<td>

```json
{
  "k_ele": [
    {
      "ke_pri": ["ichi1", "news1", "nf01"],
      "keb": "四"
    },
    {
      "keb": "４"
    },
    {
      "keb": "肆"
    }
  ],
  "r_ele": [
    {
      "re_pri": ["ichi1"],
      "reb": "し"
    },
    {
      "re_pri": ["ichi1", "news1", "nf01"],
      "re_restr": ["四"],
      "reb": "よん"
    },
    {
      "re_restr": ["四"],
      "reb": "よ"
    }
  ],
  "sense": [
    {
      "gloss": ["four", "4"],
      "pos": ["numeric"],
      "s_inf": ["肆 is used in legal documents"]
    }
  ]
}
```

</td>
  </tr>
  <tr>
    <td> 四 </td>
<td>

```json
{
  "k_ele": [
    {
      "keb": "四"
    }
  ],
  "r_ele": [
    {
      "reb": "スー"
    }
  ],
  "sense": [
    {
      "gloss": ["four"],
      "pos": ["numeric"]
    }
  ]
}
```

</td>
  </tr>
</table>

```sql
sqlite> select l.expression, e.entry from lookup l inner join entries e on e.id = l.id where l.expression = '明後日';
```

<table>
<tr>
<td> expression </td> <td> entry </td>
</tr>
<tr>
<td> 明後日 </td>
<td>

```json
{
  "k_ele": [
    {
      "ke_pri": ["ichi1"],
      "keb": "明後日"
    }
  ],
  "r_ele": [
    {
      "re_pri": ["ichi1"],
      "reb": "あさって"
    },
    {
      "re_pri": ["ichi1"],
      "reb": "みょうごにち"
    }
  ],
  "sense": [
    {
      "gloss": ["day after tomorrow"],
      "pos": ["noun (common) (futsuumeishi)", "adverb (fukushi)"]
    },
    {
      "gloss": ["wrong (e.g. direction)"],
      "pos": ["nouns which may take the genitive case particle 'no'"],
      "stagr": ["あさって"],
      "xref": ["あさっての方を向く"]
    }
  ]
}
```

</td>
</tr>
</table>

```sql
sqlite> select json_group_array(json(e.entry)) from lookup l inner join entries e on e.id = l.id where l.expression = '肆';
```
```json
[
  {
    "k_ele": [
      {
        "ke_pri": [
          "ichi1",
          "news1",
          "nf01"
        ],
        "keb": "四"
      },
      {
        "keb": "４"
      },
      {
        "keb": "肆"
      }
    ],
    "r_ele": [
      {
        "re_pri": [
          "ichi1"
        ],
        "reb": "し"
      },
      {
        "re_pri": [
          "ichi1",
          "news1",
          "nf01"
        ],
        "re_restr": [
          "四"
        ],
        "reb": "よん"
      },
      {
        "re_restr": [
          "四"
        ],
        "reb": "よ"
      }
    ],
    "sense": [
      {
        "gloss": [
          "four",
          "4"
        ],
        "pos": [
          "numeric"
        ],
        "s_inf": [
          "肆 is used in legal documents"
        ]
      }
    ]
  },
  {
    "k_ele": [
      {
        "keb": "恣"
      },
      {
        "keb": "擅"
      },
      {
        "keb": "縦"
      },
      {
        "keb": "肆"
      }
    ],
    "r_ele": [
      {
        "reb": "ほしいまま"
      }
    ],
    "sense": [
      {
        "gloss": [
          "selfish",
          "self-indulgent",
          "arbitrary"
        ],
        "misc": [
          "word usually written using kana alone"
        ],
        "pos": [
          "adjectival nouns or quasi-adjectives (keiyodoshi)"
        ]
      }
    ]
  }
]
```
