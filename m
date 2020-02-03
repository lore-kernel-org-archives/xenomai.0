Subject: Re: [PATCH 0/8] Assorted fixes
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <3ea47e07-11c5-de22-2c21-c3adc028720a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <60a2866e-ee51-2576-e5bc-a96c705a972d@xenomai.org>
Date: Mon, 3 Feb 2020 19:21:28 +0100
MIME-Version: 1.0
In-Reply-To: <3ea47e07-11c5-de22-2c21-c3adc028720a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 2/3/20 6:55 PM, Jan Kiszka wrote:
> On 31.01.20 16:27, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> The first four commits fix the doc generation which has been broken
>> for some time, the rest addresses runtime issues detected in the
>> field. See commit logs for details.
>>
>> These patches are on top of the master branch.
>>
>> Philippe Gerum (8):
>>    doc: fix assorted Doxygen warnings
>>    doc: do not discard pdflatex output
>>    build: fix make distcheck
>>    doc: fix asciidoc generation
> 
> I've just tried to reproduce the doc build, but maybe I'm missing a 
> tool, or we have complex version dependencies:
> 
> make[3]: Entering directory '/data/xenomai/build64/doc/doxygen/latex/xeno3prm'
> rm -f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl refman.pdf
> pdflatex refman
> This is pdfTeX, Version 3.14159265-2.6-1.40.18 (TeX Live 2017/TeX Live for SUSE Linux) (preloaded format=pdflatex)
>  restricted \write18 enabled.
> entering extended mode
> (./refman.tex
> LaTeX2e <2017-04-15>
> Babel <3.10> and hyphenation patterns for 51 language(s) loaded.
> 
> make[3]: *** [Makefile:6: refman.pdf] Error 1
> make[3]: Leaving directory '/data/xenomai/build64/doc/doxygen/latex/xeno3prm'
> make[2]: *** [Makefile:538: xeno3prm.pdf] Error 2
> make[2]: Leaving directory '/data/xenomai/build64/doc/doxygen'
> make[1]: *** [Makefile:408: all-recursive] Error 1
> make[1]: Leaving directory '/data/xenomai/build64/doc'
> make: *** [Makefile:459: all-recursive] Error 1
> 
> Any idea?
> 
> What's your setup exactly? What falls under "Dot packages" on your 
> distro?
> 
> Jan
> 

You might also have an issue with pdflatex which might fail with a
cryptic error on generating refman.pdf. You may want to pass
--enable-verbose-latex to get information about the failure.

-- 
Philippe.

