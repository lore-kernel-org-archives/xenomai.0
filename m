Message-ID: <5447A31C.6050102@xenomai.org>
Date: Wed, 22 Oct 2014 14:29:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D06C3EF5.19661%shartmann@cnt.canon.com>
 <20141022050529.GA29673@sisyphus.hd.free.fr>
 <D06CF843.1966B%shartmann@cnt.canon.com>
In-Reply-To: <D06CF843.1966B%shartmann@cnt.canon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/22/2014 01:09 PM, Steve Hartmann wrote:
> 
> On 10/22/14 12:05 AM, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On Tue, Oct 21, 2014 at 09:48:55PM +0000, Steve Hartmann wrote:
>>> Hi All,
>>>
>>> I am having a really strange and hard to troubleshoot problem on
>>> multiple systems and hope that someone here could maybe throw some
>>> tips my way.  I am running Xenomai 2.6.4 on linux 3.4.6, amd64.
>>
>> Do you observe the same behaviour with the I-pipe patch for Linux
>> 3.14.17 that comes with Xenomai 2.6.4?
>>
>> -- 
>> 					    Gilles.
> 
> Unfortunately there is no patched version of the e1000e driver for
> Etherlabs Ethercat stack for that linux version, so I have not tried it.
> I will look into the effort level to do the e1000e port myself.  Did you
> mention that version because it addresses an issue similar to mine?
> 
No, I was just saying that because 3.4 is a bit old, so a lot of things
have been fixed since then and I would find it a waste of time to
investigate a bug which has been solved in the mean time. Have you not
observed the bug without the e1000 driver?

Anyway, if you want to investigate the issue, the first thing to do is
to setup a console output (preferably serial) to another PC, and log the
messages you get before the issue happens. Then enable the I-pipe and
xenomai debug, and see if you get more messages.

-- 
                                                                Gilles.

