From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [Xenomai] [PATCH] boilerplate/avl: fix missing include
Date: Wed, 24 Oct 2018 12:33:49 +0200
Message-ID: <13058881.nZKSyxvzTL@lenni>
In-Reply-To: <212cc963-4cb6-2e0d-67db-f74b2719f15f@xenomai.org>
References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
 <36670432.JDg3nDlJl9@lenni>
 <212cc963-4cb6-2e0d-67db-f74b2719f15f@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/23/18 11:11 AM, Philippe Gerum wrote:
> On 10/19/18 5:10 PM, Sebastian Smolorz wrote:
> > Hello Philippe,
> > 
> > Sebastian Smolorz wrote:
> >> On 10/19/2018 09:16 AM, Philippe Gerum wrote:
> >>> On 10/18/2018 04:37 PM, Sebastian Smolorz wrote:
> >>>> Nevertheless, I guess there is an issue with the definition of
> >>>> const
> >>>> (line 50) in include/boilerplate/compiler.h. It does work with
> >>>> gcc
> >>>> 5.4 but not with gcc 4.3.5.
> >>> 
> >>> Could you elaborate on this? Which error pops us, in which
> >>> context?
> >> 
> >> Compilation of libboilerplate and libiniparser (master and next)
> >> fails with a cross gcc 4.3.5 for x86_32 (i586) targets. If I
> >> change the line mentioned above into
> >> 
> >> #define __const const
> >> 
> >> the error does not pop up any more. Works also when I completely
> >> remove the #define __const.
> > 
> > I've found two additional compile errors due to the usage of ancient
> > gcc and glibc. I could prepare patches for that. But I'm not sure
> > how to fix this __const issue properly. I've seen that you
> > introduced those lines in commit  5632adb8 into -next. I suppose
> > you faced an issue which needed this fix, am I correct?
> 
> Adding constness to a function was needed at some point, __const was
> meant to be a shorthand for annotating the code. You did not provide
> the error message received from gcc 4.3 so I can't be sure, however
> the following change might fix the issue:
> 
> diff --git a/include/boilerplate/compiler.h
> b/include/boilerplate/compiler.h index f526eb269..469d0c249 100644
> --- a/include/boilerplate/compiler.h
> +++ b/include/boilerplate/compiler.h
> @@ -47,7 +47,7 @@
>  #endif
> 
>  #ifndef __const
> -#define __const		__attribute__((__const__))
> +#define __const		__attribute__((const))
>  #endif
> 
>  #ifndef __pure

That does not change the error. The condensed error output is:

  CC       libboilerplate_la-ancillaries.lo
cc1: warnings being treated as errors
lib/boilerplate/iniparser/dictionary.c: In function 'xstrdup':
lib/boilerplate/iniparser/dictionary.c:72: error: passing argument 1 of 
'strlen' discards qualifiers from pointer target type
lib/boilerplate/iniparser/dictionary.c:74: error: passing argument 2 of 
'strcpy' discards qualifiers from pointer target type
lib/boilerplate/iniparser/dictionary.c: In function 'dictionary_hash':
lib/boilerplate/iniparser/dictionary.c:100: error: passing argument 1 of 
'strlen' discards qualifiers from pointer target type
lib/boilerplate/iniparser/dictionary.c: In function 'dictionary_get':
lib/boilerplate/iniparser/dictionary.c:193: error: passing argument 1 of 
'strlen' discards qualifiers from pointer target type
lib/boilerplate/iniparser/dictionary.c:193: error: 'const' attribute 
ignored
lib/boilerplate/iniparser/dictionary.c:193: error: 'const' attribute 
does not apply to types
lib/boilerplate/iniparser/dictionary.c: In function 'dictionary_set':
lib/boilerplate/iniparser/dictionary.c:242: error: passing argument 1 of 
'strlen' discards qualifiers from pointer target type
lib/boilerplate/iniparser/dictionary.c:242: error: 'const' attribute 
ignored
lib/boilerplate/iniparser/dictionary.c:242: error: 'const' attribute 
does not apply to types
lib/boilerplate/iniparser/dictionary.c: In function 'dictionary_unset':
lib/boilerplate/iniparser/dictionary.c:311: error: passing argument 1 of 
'strlen' discards qualifiers from pointer target type
lib/boilerplate/iniparser/dictionary.c:311: error: 'const' attribute 
ignored
lib/boilerplate/iniparser/dictionary.c:311: error: 'const' attribute 
does not apply to types

cc1: warnings being treated as errors
lib/boilerplate/iniparser/iniparser.c: In function 'strstrip':
lib/boilerplate/iniparser/iniparser.c:92: error: passing argument 2 of 
'strcpy' discards qualifiers from pointer target type
lib/boilerplate/iniparser/iniparser.c: In function 'iniparser_dump_ini':
lib/boilerplate/iniparser/iniparser.c:237: error: passing argument 1 of 
'strlen' discards qualifiers from pointer target type
lib/boilerplate/iniparser/iniparser.c:243: error: 'const' attribute 
ignored
lib/boilerplate/iniparser/iniparser.c:243: error: 'const' attribute does 
not apply to types
lib/boilerplate/iniparser/iniparser.c: In function 'iniparser_getint':
lib/boilerplate/iniparser/iniparser.c:314: error: passing argument 1 of 
'strtol' discards qualifiers from pointer target type
lib/boilerplate/iniparser/iniparser.c: In function 
'iniparser_getdouble':
lib/boilerplate/iniparser/iniparser.c:336: error: passing argument 1 of 
'atof' discards qualifiers from pointer target type
lib/boilerplate/iniparser/iniparser.c: In function 'iniparser_line':
lib/boilerplate/iniparser/iniparser.c:492: error: 'const' attribute 
ignored
lib/boilerplate/iniparser/iniparser.c:492: error: 'const' attribute does 
not apply to types
In file included from lib/boilerplate/ancillaries.c:27:
i586-nptl-linux-gnu/bin/../i586-nptl-linux-gnu/sys-root/usr/include/
ctype.h:82: error: expected ')' before '__attribute__'
i586-nptl-linux-gnu/bin/../i586-nptl-linux-gnu/sys-root/usr/include/
ctype.h:82: error: expected ',' or ';' before ')' token
i586-nptl-linux-gnu/bin/../i586-nptl-linux-gnu/sys-root/usr/include/
ctype.h:84: error: expected ')' before '__attribute__'
i586-nptl-linux-gnu/bin/../i586-nptl-linux-gnu/sys-root/usr/include/
ctype.h:84: error: expected ',' or ';' before ')' token
i586-nptl-linux-gnu/bin/../i586-nptl-linux-gnu/sys-root/usr/include/
ctype.h:86: error: expected ')' before '__attribute__'
i586-nptl-linux-gnu/bin/../i586-nptl-linux-gnu/sys-root/usr/include/
ctype.h:86: error: expected ',' or ';' before ')' token

cc1: warnings being treated as errors
lib/boilerplate/ancillaries.c: In function 
'__get_online_cpus_from_proc':
lib/boilerplate/ancillaries.c:339: error: 'const' attribute ignored
lib/boilerplate/ancillaries.c:339: error: 'const' attribute does not 
apply to types
lib/boilerplate/ancillaries.c: In function 'get_online_cpu_set':
lib/boilerplate/ancillaries.c:373: error: 'const' attribute does not 
apply to types
lib/boilerplate/ancillaries.c: In function 'get_mem_size':
lib/boilerplate/ancillaries.c:492: error: passing argument 1 of 'strtol' 
discards qualifiers from pointer target type

Thanks,

-- 
Sebastian




