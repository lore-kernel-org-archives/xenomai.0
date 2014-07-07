Message-ID: <53BAC5C4.5060704@xenomai.org>
Date: Mon, 07 Jul 2014 18:07:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404210421-17081-1-git-send-email-maxime.ripard@free-electrons.com>
 <53B294A7.5010803@xenomai.org> <20140701141536.GN28647@lukather>
 <53B30D96.60500@xenomai.org> <20140704092736.GC13487@lukather>
 <53B7B3BF.3090807@xenomai.org> <20140707160239.GF13423@lukather>
In-Reply-To: <20140707160239.GF13423@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/07/2014 06:02 PM, Maxime Ripard wrote:
> On Sat, Jul 05, 2014 at 10:13:51AM +0200, Gilles Chanteperdrix
> wrote:
>>>>> Ok, so, with the changes you mentionned, I can't make the
>>>>> system crash anymore (or at least, not as easily as it used
>>>>> to be).
>>>>> 
>>>>> But: - whenever the program mentionned above calls exit(),
>>>>> it stalls. However, ctrl+c makes the program exit properly,
>>>>> and everything seems fine otherwise - whenever we don't
>>>>> link it against xenomai, it just hangs. I've not figured
>>>>> out why yet
>>>>> 
>>>>> With CONFIG_XENOMAI and CONFIG_IPIPE disabled, it works
>>>>> fine.
>>>> 
>>>> My answer was wrong, you probably need to keep the 
>>>> set_backup/clear_backup calls in he ->hold and ->release
>>>> callbacks, as the linux interrupt may expect the backup areas
>>>> to be in sync. Did you do this, or did you go for the
>>>> alternative?
>>> 
>>> I went for the alternative. I'm sending you a v2 with what I
>>> have so far, that shows the behaviour I was describing.
>> 
>> Could you try the following patch?
> 
> It actually works much better, thanks!
> 
> The above mentionned issues are gone, there's only one last glitch
> I guess. The max latency under load is around a few 100's of ms
> (while idle, it's actually around 200-300us, which seems more
> reasonable.

200us or 300us seems high for a last generation cortex. milliseconds
issues indicate an issue, does the msw column in latency increment?

> 
> Maxime
> 


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTusXEGpcgE6m/fboRApbPAJwPqwDkMixnpMskG72oNprm8SCLlQCcCghd
mGkWJQwDvTtfUsFlQt3L/Q4=
=vyT1
-----END PGP SIGNATURE-----

