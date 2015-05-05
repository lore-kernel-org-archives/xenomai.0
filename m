Date: Tue, 5 May 2015 19:21:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150505172113.GO1993@hermes.click-hack.org>
References: <553FAC36.3050803@free.fr> <553FC281.70308@xenomai.org>
 <5541D505.2000109@free.fr> <5541E930.30000@xenomai.org>
 <5542205E.5080302@free.fr> <5548C7A4.5030309@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5548C7A4.5030309@free.fr>
Subject: Re: [Xenomai] xenomai 3.0rc4 rt_heap_alloc replies with timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?U3TDqXBoYW5l?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 05, 2015 at 03:37:40PM +0200, Stéphane ANCELOT wrote:
> Hi,
> unfortunately, There is something wrong for unknown reason using these
> functions.
> 
> I made a simple regression program that only create heaps and allocates
> area.
> 
> At line 190 of the file, depending on the size value of the heap, the
> program works or not.
> This looks like corrupted memory problem...

I do not see anything in your reports would could make think of a
corrupted memory problem. Are you sure this is not simply a problem
in the overhead calculation? Have you tried to call rt_heap_inquire
between rt_heap_create and rt_heap_alloc to see if the usablemem
field shows a big enough value?

-- 
					    Gilles.

