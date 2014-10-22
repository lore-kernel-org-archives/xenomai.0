MIME-Version: 1.0
Sender: hiddeate2m@gmail.com
In-Reply-To: <D06CF843.1966B%shartmann@cnt.canon.com>
References: <D06C3EF5.19661%shartmann@cnt.canon.com>
 <20141022050529.GA29673@sisyphus.hd.free.fr>
 <D06CF843.1966B%shartmann@cnt.canon.com>
Date: Wed, 22 Oct 2014 13:53:14 +0200
Message-ID: <CAMi4Dw2XGkYPh=pU+FCWCRjGTpxBL5Ex5CFeW-W-gqGpFO6Ubw@mail.gmail.com>
From: "Hidde Verstoep (E2M)" <hverstoep@e2mtechnologies.eu>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Troubleshooting general protection faults
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Hartmann <shartmann@cnt.canon.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Oct 22, 2014 at 1:09 PM, Steve Hartmann <shartmann@cnt.canon.com> wrote:
>
> On 10/22/14 12:05 AM, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
>
>>On Tue, Oct 21, 2014 at 09:48:55PM +0000, Steve Hartmann wrote:
>>> Hi All,
>>>
>>> I am having a really strange and hard to troubleshoot problem on
>>> multiple systems and hope that someone here could maybe throw some
>>> tips my way.  I am running Xenomai 2.6.4 on linux 3.4.6, amd64.
>>
>>Do you observe the same behaviour with the I-pipe patch for Linux
>>3.14.17 that comes with Xenomai 2.6.4?
>>
>>--
>>                                           Gilles.
>
> Unfortunately there is no patched version of the e1000e driver for
> Etherlabs Ethercat stack for that linux version, so I have not tried it.
> I will look into the effort level to do the e1000e port myself.  Did you
> mention that version because it addresses an issue similar to mine?

In case you start porting the Etherlabs e1000e driver and it is too
much effort: you could try to write a driver for Etherlabs that uses
the RTnet network stack. You could base this new Etherlabs driver on
the existing Etherlabs driver ("generic.c") that uses the linux
network stack.

RTnet generally works well with Xenomai and it has a lot drivers
(including one for e1000e). So, this might also be interesting if you
need support for other network cards in the future. I'm not sure
though whether RTnet works with 3.14.17, but perhaps somebody else
could tell you that.

Hidde Verstoep

