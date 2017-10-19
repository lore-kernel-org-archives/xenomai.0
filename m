From: Philippe Gerum <rpm@xenomai.org>
References: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
 <20170810114956.04f62bc6@md1em3qc>
 <CADYdroM8E7jhuyRoW4JkSzZfGg27VvpjLmHGmMmX79wgEqPJog@mail.gmail.com>
 <20171012103345.04d854c2@md1em3qc>
 <CADYdroOAVb0wPAvuynvuOUtSnp85FT2Ett80amzDpDCFHPHHzA@mail.gmail.com>
 <CADYdroNeQOY2MN-b=r6bNh=69oeGP2oWry2CXHYH9RJtTt1MFA@mail.gmail.com>
 <CADYdroN-yNG+nLrhfiH8MgMVr7D82-wNnjvyVXcX6hNU2mikcg@mail.gmail.com>
 <20171013113118.6e6f0fcd@md1em3qc>
 <CADYdroPP8ZQ91eqfJjJP9UFufpJOWm7+zsDePz-0a_TaDV_9_Q@mail.gmail.com>
 <20171013122653.1adbf99e@md1em3qc>
 <CADYdroP7G6irhKJUtpWfoVdivT3ey_i58zAvMz-O7E7PycH6ug@mail.gmail.com>
 <08ed4b28-608a-4a3b-6946-d910861017d3@xenomai.org>
 <99BAB48E90E86D42AD41F0BCE3225AEB017BFC342A@GRZSMS582.andritz.com>
Message-ID: <852056b2-6ad6-8feb-e864-d22ced13dd0c@xenomai.org>
Date: Thu, 19 Oct 2017 15:00:59 +0200
MIME-Version: 1.0
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB017BFC342A@GRZSMS582.andritz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Won`t build on new Debian Stable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Norbert Lange <nolange79@gmail.com>, Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 10/19/2017 01:32 PM, Lange Norbert wrote:
> Hello,
> 
>> I don't know the original intent about passing -Ur to the linker, except
>  >maybe to stick to the ld manpage which states that the last partial link
>  >command should be given such option.
> 
> I understand that differently, you can't use this flag in anything but the
> last partial link. Not that you should do it.

Which is my interpretation as well.

> 
> Further I agree that -Ur is, to my best knowledge, not needed at all.
> It might make sense if you want to do something directly with the
> Resulting object, but if final link to App or Library is some "standard"
> link then the tables are built there.
> It might actually create problems if some symbols (weak, inline)
> would be resolved differently in the final link.
> 
> Further, if I look at this ld switch:
> " --warn-constructors
> Warn if any global constructors are used. This is only useful for a few object file formats.
> For formats like COFF or ELF, the linker can not detect the use of global constructors."
>

Maybe not (although it is not obvious reading the binutils/ld code
populating the linker's hash table), but ld knows about collect2, which
detects such use.

> Then I am not even sure the linker will do ANYTHING differently with -Ur for ELF.> Such constructor functions pointers are placed in a special linker
section ".init_array",
> and the startup-code or the dynamic loader iterates on that array. There is
> nothing C++ specific.

I would assume the opposite. The ld doc says: "When linking C ++
programs, -Ur does resolve references to constructors". Also, the
previous discussion referred to collect2 as the breaking point when -r
and -pie conflict, which confirms it may be a C++ specific issue given
the purpose of collect2, which triggers due to a discrepancy between
gcc, collect2 and ld when it comes to partially linking pie code.

In addition, my understanding is that those references you mention are
not directly handled as ELF constructor routines, but indirectly by an
init handler called by the early C++ runtime code, which iterates over
those tables (over glibc's libc_start_main entry point for the ctor part).

> 
> How about using your supposed change and adding some comments that
> "-Wl,-Ur" was removed as hint?
> 

I asked earlier for C++ users to test that change in wrap-link.sh first,
not to break the stable branch for them. If nobody complains after a
couple of weeks, the change should definitely be merged.

-- 
Philippe.


