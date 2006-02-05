From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17381.63583.528140.947367@domain.hid>
Date: Sun, 5 Feb 2006 14:06:39 +0100
Subject: Re: [Xenomai-core] broken docs
In-Reply-To: <43E49D07.2070705@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>
	<43DE03CF.3070603@domain.hid>
	<17374.2360.273205.998312@domain.hid>
	<43DE0DA0.2050307@domain.hid> <43E49D07.2070705@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Jan Kiszka wrote:
 > > Gilles Chanteperdrix wrote:
 > >> Looking at the difference between RTDM documentation blocks and the
 > >> other modules is that the other modules use the "fn" tag. Removing the
 > >> "fn" tag from other modules documentation blocks seems to solve the
 > >> issue.
 > >>
 > > 
 > > Indeed, works. Amazingly blind I was.
 > > 
 > > Anyway, it still needs some work to remove that stuff (I wonder what the
 > > "correct" usage of @fn is...) and to wrap functions without bodies via
 > > "#ifdef DOXYGEN_CPP" like RTDM does. At this chance, I would also
 > > suggest to replace all \tag by @tag for the sake of a unified style (and
 > > who knows what side effects mixing up both may have).
 > > 
 > 
 > Here is a shell script aiming at an automated fix for parts of the
 > mentioned issues. Anyone with better shell hacking skills may improve it
 > (I'm always willing to learn!).
 > 
 > for file in `find -name "*.[c|h]"`; do
 >     mv $file $file.tmp
 >     cat $file.tmp | (
 >         echo $file
 >         while read -r; do
 >             # delete " * @fn ..." lines
 >             new_line="`echo "$REPLY" | sed 's/\ \*\ @fn[^$]*$//' | \
 >                 tr -d "\n"`"
 >             if echo "$REPLY" | grep -q '\ \*\ @fn[^$]*$'; then
 >                 # delete empty comment lines succeeding " * @fn ..."
 >                 read -r
 >                 if [ "$REPLY" != " *" ]; then
 >                     echo "$REPLY" >> $file
 >                 fi
 >             else
 >                 # convert " * \<tag>" to " * @<tag>"
 >                 echo "$new_line" | sed 's/\ \*\ \\\([a-z]\)/ * @\1/' \
 >                     >> $file
 >             fi
 >         done
 >     )
 >     rm $file.tmp
 > done
 > 
 > 
 > I only tested it on ksrs/skins/native, but it seems to work - for those
 > functions with a body :-/. We still need to manually wrap body-less
 > function docs as it is done in the rtdm skin. But I think this is a start.

The point is that the @fn tags improve readability of documentation
blocks, so, it would be nice if we could keep them. Simple tests with
the same Doxyfile as Xenomai show that the @fn tag works as expected, so
the problem may be due to something else. Now that I think about it,
the way we dealt with EXPORT_SYMBOL in Doxyfile is probably the culprit,
and the fix looks quite simple on elementary tests.

-- 


					    Gilles Chanteperdrix.

