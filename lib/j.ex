defmodule J do
  @moduledoc File.read!("README.md")

  @typedoc """
  Entries consist of kanji elements, reading elements,
  general information and sense elements. Each entry must have at
  least one reading element and one sense element. Others are optional.
  """
  @type entry :: %{
          # A unique numeric sequence number for each entry
          ent_seq: number(),

          # The kanji element, or in its absence, the reading element, is
          # the defining component of each entry.

          # The overwhelming majority of entries will have a single kanji
          # element associated with a word in Japanese. Where there are
          # multiple kanji elements within an entry, they will be orthographical
          # variants of the same word, either using variations in okurigana, or
          # alternative and equivalent kanji. Common "mis-spellings" may be
          # included, provided they are associated with appropriate information
          # fields. Synonyms are not included; they may be indicated in the
          # cross-reference field associated with the sense element.
          k_ele: [
            %{
              # This element will contain a word or short phrase in Japanese
              # which is written using at least one non-kana character (usually kanji,
              # but can be other characters). The valid characters are
              # kanji, kana, related characters such as chouon and kurikaeshi, and
              # in exceptional cases, letters from other alphabets.
              keb: String.t(),
              # This is a coded information field related specifically to the
              # orthography of the keb, and will typically indicate some unusual
              # aspect, such as okurigana irregularity.
              ke_inf: [String.t()],
              # This and the equivalent re_pri field are provided to record
              # information about the relative priority of the entry,  and consist
              # of codes indicating the word appears in various references which
              # can be taken as an indication of the frequency with which the word
              # is used. This field is intended for use either by applications which
              # want to concentrate on entries of  a particular priority, or to
              # generate subset files.

              # The current values in this field are:

              # - news1/2: appears in the "wordfreq" file compiled by Alexandre Girardi
              # from the Mainichi Shimbun. (See the Monash ftp archive for a copy.)
              # Words in the first 12,000 in that file are marked "news1" and words
              # in the second 12,000 are marked "news2".

              # - ichi1/2: appears in the "Ichimango goi bunruishuu", Senmon Kyouiku
              # Publishing, Tokyo, 1998.  (The entries marked "ichi2" were
              # demoted from ichi1 because they were observed to have low
              # frequencies in the WWW and newspapers.)

              # - spec1 and spec2: a small number of words use this marker when they
              # are detected as being common, but are not included in other lists.

              # - gai1/2: common loanwords, based on the wordfreq file.

              # - nfxx: this is an indicator of frequency-of-use ranking in the
              # wordfreq file. "xx" is the number of the set of 500 words in which
              # the entry can be found, with "01" assigned to the first 500, "02"
              # to the second, and so on. (The entries with news1, ichi1, spec1, spec2
              # and gai1 values are marked with a "(P)" in the EDICT and EDICT2
              # files.)

              # The reason both the kanji and reading elements are tagged is because
              # on occasions a priority is only associated with a particular
              # kanji/reading pair.
              ke_pri: [String.t()]
            }
          ],
          # The reading element typically contains the valid readings
          # of the word(s) in the kanji element using modern kanadzukai.
          # Where there are multiple reading elements, they will typically be
          # alternative readings of the kanji element. In the absence of a
          # kanji element, i.e. in the case of a word or phrase written
          # entirely in kana, these elements will define the entry.
          r_ele: [
            %{
              # this element content is restricted to kana and related
              # characters such as chouon and kurikaeshi. Kana usage will be
              # consistent between the keb and reb elements; e.g. if the keb
              # contains katakana, so too will the reb.
              reb: String.t(),
              # This element, which will usually have a null value, indicates
              # that the reb, while associated with the keb, cannot be regarded
              # as a true reading of the kanji. It is typically used for words
              # such as foreign place names, gairaigo which can be in kanji or
              # katakana, etc.
              re_nokanji: String.t() | nil,
              # This element is used to indicate when the reading only applies
              # to a subset of the keb elements in the entry. In its absence, all
              # readings apply to all kanji elements. The contents of this element
              # must exactly match those of one of the keb elements.
              re_restr: [String.t()],
              # General coded information pertaining to the specific reading.
              # Typically it will be used to indicate some unusual aspect of
              # the reading.
              re_inf: [String.t()],
              # See the comment on ke_pri above.
              re_pri: [String.t()]
            }
          ],
          # The sense element will record the translational equivalent
          # of the Japanese word, plus other related information. Where there
          # are several distinctly different meanings of the word, multiple
          # sense elements will be employed.
          sense: [
            %{
              # These elements, if present, indicate that the sense is restricted
              # to the lexeme represented by the keb and/or reb.
              stagk: [String.t()],
              # These elements, if present, indicate that the sense is restricted
              # to the lexeme represented by the keb and/or reb.
              stagr: [String.t()],
              # Part-of-speech information about the entry/sense. Should use
              # appropriate entity codes. In general where there are multiple senses
              # in an entry, the part-of-speech of an earlier sense will apply to
              # later senses unless there is a new part-of-speech indicated.
              pos: [String.t()],
              # This element is used to indicate a cross-reference to another
              # entry with a similar or related meaning or sense. The content of
              # this element is typically a keb or reb element in another entry. In some
              # cases a keb will be followed by a reb and/or a sense number to provide
              # a precise target for the cross-reference. Where this happens, a JIS
              # "centre-dot" (0x2126) is placed between the components of the
              # cross-reference. The target keb or reb must not contain a centre-dot.
              xref: [String.t()],
              # This element is used to indicate another entry which is an
              # antonym of the current entry/sense. The content of this element
              # must exactly match that of a keb or reb element in another entry.
              ant: [String.t()],
              # Information about the field of application of the entry/sense.
              # When absent, general application is implied. Entity coding for
              # specific fields of application.
              field: [String.t()],
              # This element is used for other relevant information about
              # the entry/sense. As with part-of-speech, information will usually
              # apply to several senses
              misc: [String.t()],
              # The sense-information elements provided for additional
              # information to be recorded about a sense. Typical usage would
              # be to indicate such things as level of currency of a sense, the
              # regional variations, etc.
              s_inf: [String.t()],
              # TODO
              # This element records the information about the source
              # language(s) of a loan-word/gairaigo. If the source language is other
              # than English, the language is indicated by the xml:lang attribute.
              # The element value (if any) is the source word or phrase.
              lsource: [String.t()],
              # For words specifically associated with regional dialects in
              # Japanese, the entity code for that dialect, e.g. ksb for Kansaiben.
              dial: [String.t()],
              # TODO
              # Within each sense will be one or more "glosses", i.e.
              # target-language words or phrases which are equivalents to the
              # Japanese word. This element would normally be present, however it
              # may be omitted in entries which are purely for a cross-reference.
              gloss: [
                %{
                  # These elements highlight particular target-language words which
                  # are strongly associated with the Japanese word. The purpose is to
                  # establish a set of target-language words which can effectively be
                  # used as head-words in a reverse target-language/Japanese relationship.
                  pri: String.t()
                }
              ],
              # The example elements contain a Japanese sentence using the term
              # associated with the entry, and one or more translations of that sentence.
              # Within the element, the ex_srce element will indicate the source of the
              # sentences (typically the sequence number in the Tatoeba Project), the
              # ex_text element will contain the form of the term in the Japanese
              # sentence, and the ex_sent elements contain the example sentences.
              example: [
                %{
                  ex_srce: String.t(),
                  ex_text: String.t(),
                  ex_sent: [String.t()]
                }
              ]
            }
          ]
        }

  @type jmdict :: [entry]

  import SweetXml
  require Logger
  alias Exqlite.Sqlite3

  def open_db(name) do
    {:ok, conn} = Sqlite3.open(name)
    :ok = Sqlite3.execute(conn, "pragma synchronous = normal")
    :ok = Sqlite3.execute(conn, "pragma journal_mode=wal")

    :ok =
      Sqlite3.execute(
        conn,
        "create table if not exists entries(id integer primary key, entry text not null) without rowid, strict"
      )

    :ok =
      Sqlite3.execute(
        conn,
        # TODO covering index?
        "create table if not exists lookup(expression text not null, id integer not null, primary key(expression, id)) without rowid, strict"
        # "create table if not exists lookup(expression text not null, id integer not null) strict"
      )

    # :ok = Sqlite3.execute(conn, "create index if not exists lookup_idx on lookup(expression)")

    conn
  end

  # adapted https://github.com/bchase/jmdict-elixir/blob/master/lib/jmdict/entry_xml.ex
  # similar: https://github.com/jcrevits/anki-feeder
  #          https://github.com/rnice01/ja_dictionary
  #          https://github.com/FooSoft/jmdict/blob/master/jmdict.go
  #          https://github.com/echamudi/japanese-toolkit/tree/master/packages/japanese-db
  # TODO Tanaka_Corpus: http://www.edrdg.org/wiki/index.php/JMdict-EDICT_Dictionary_Project
  def jmdict_stream(path \\ "JMdict_e") do
    path
    |> File.stream!()
    |> SweetXml.stream_tags!(:entry)
    |> Stream.map(fn {:entry, entry} ->
      entry
      |> SweetXml.xpath(~x"//entry"e,
        eid: ~x"./ent_seq/text()"s,
        # KANJI
        k_ele: [
          ~x"./k_ele"le,
          keb: ~x"./keb/text()"s,
          ke_inf: ~x"./ke_inf/text()"ls,
          ke_pri: ~x"./ke_pri/text()"ls
        ],
        # KANA
        r_ele: [
          ~x"./r_ele"le,
          reb: ~x"./reb/text()"s,
          re_inf: ~x"./re_inf/text()"ls,
          re_pri: ~x"./re_pri/text()"ls,
          # TODO
          re_nokanji: ~x"./re_nokanji"e,
          re_restr: ~x"./re_restr/text()"ls
        ],
        # SENSES (GLOSSES)
        sense: [
          ~x{./sense}le,
          stagk: ~x{./stagk/text()}ls,
          stagr: ~x{./stagr/text()}ls,
          # full ex: <xref>彼・あれ・1</xref>
          xref: ~x{./xref/text()}ls,
          # prior ./sense/pos apply, unless new added
          pos: ~x{./pos/text()}ls,
          field: ~x{./field/text()}ls,
          # "usually apply to several senses"
          misc: ~x{./misc/text()}ls,
          dial: ~x{./dial/text()}ls,
          gloss: ~x{./gloss/text()}ls,
          s_inf: ~x{./s_inf/text()}ls,
          # attr xml:lang="eng" (default) ISO 639-2
          lsource: ~x{./lsource}le
          # attr ls_wasei="y" means "yes" e.g. waseieigo
        ]
      )
      |> prepare_entry()
    end)
  end

  defp prepare_entry(entry) do
    cleaner = fn list -> Enum.map(list, &drop_empty/1) end

    entry
    |> Map.update!(:eid, &String.to_integer/1)
    |> Map.update!(:k_ele, cleaner)
    |> Map.update!(:r_ele, cleaner)
    |> Map.update!(:sense, cleaner)
  end

  defp drop_empty(map) when is_map(map) do
    # TODO
    map
    |> Enum.reject(fn {k, v} -> is_nil(v) or v == [] or k == :re_nokanji or k == :lsource end)
    |> Map.new()
  end

  def save(input \\ "JMdict_e", output \\ "jmdict-covering.db") do
    conn = open_db(output)
    :ok = Sqlite3.execute(conn, "delete from entries")
    :ok = Sqlite3.execute(conn, "delete from lookup")

    {:ok, entry_stmt} = Sqlite3.prepare(conn, "insert into entries(id, entry) values (?, ?)")
    {:ok, lookup_stmt} = Sqlite3.prepare(conn, "insert into lookup(expression, id) values (?, ?)")

    :ok = Sqlite3.execute(conn, "begin")

    try do
      jmdict_stream(input)
      |> Stream.each(fn entry ->
        :ok =
          Sqlite3.bind(conn, entry_stmt, [
            entry.eid,
            entry |> Map.delete(:eid) |> Jason.encode_to_iodata!()
          ])

        :done = Sqlite3.step(conn, entry_stmt)

        kebs = Enum.map(entry.k_ele, & &1.keb)
        rebs = Enum.map(entry.r_ele, & &1.reb)

        Enum.each(kebs ++ rebs, fn expression ->
          :ok = Sqlite3.bind(conn, lookup_stmt, [expression, entry.eid])
          :done = Sqlite3.step(conn, lookup_stmt)
        end)
      end)
      |> Stream.run()
    rescue
      e ->
        Logger.error(Exception.format(:error, e, __STACKTRACE__))
        :ok
    end

    :ok = Sqlite3.execute(conn, "commit")
    :ok = Sqlite3.release(conn, entry_stmt)
    :ok = Sqlite3.release(conn, lookup_stmt)
    :ok = Sqlite3.execute(conn, "pragma wal_checkpoint(truncate)")
    :ok = Sqlite3.close(conn)
  end
end
