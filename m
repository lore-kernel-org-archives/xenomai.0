Message-ID: <4C1A434A.2070704@domain.hid>
Date: Thu, 17 Jun 2010 17:46:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinRyxZ-BB_VwB2XPYwIPik8to_eynd-c-nNulQ1@domain.hid>	<4C19EDA4.2030601@domain.hid>	<4C1A040F.4030209@domain.hid>
	<AANLkTikMtR9kMd424sXIUdULJlaRxKIlJ19ElJ4Pt4o1@domain.hid>
In-Reply-To: <AANLkTikMtR9kMd424sXIUdULJlaRxKIlJ19ElJ4Pt4o1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] application make file
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> On Thu, Jun 17, 2010 at 7:16 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>> Everett Wang wrote:
>>>> Hi All,
>>>>
>>>> Now my application based user space xenomai has a few files and I want
>>>> to construct a Makefile to compile them. I looked at the
>>>> Makefiles in examples folder. It is not straight forward to modify one
>>>> for myself. I have c files and header files.  It is possible to get
>>>> a makefile with minor changes so it can automatically find the
>>>> dependence of c and h files?
>>> You can do this quite easily with GNU make.
>> Namely:
>> http://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisites.html#Automatic-Prerequisites
>>
>> --
>>                                            Gilles.
>>
> 
> Thanks Gilles,
> 
> I can construct a Makefile for a non realtime application
> with multiple files. What I don't know are the extra flags
> for compiling and linking that xenomai requires. My
> thinking is that after I have a normal (non xenomai) Makefile,
> I can just add the compile flags when I compile each of the files
> and add linking flags to produce a real time final program.

If the hacker approach, that is, reading the Makefiles and see how they
obtain the flags is too complex for you, then use the mere human
approach: read the documentation.

-- 
					    Gilles.

