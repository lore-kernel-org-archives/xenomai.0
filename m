Message-ID: <4C743318.2010307@domain.hid>
Date: Tue, 24 Aug 2010 23:01:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C73EC62.80703@domain.hid>	<1282669146.1961.153.camel@domain.hid>	<4C73FBD5.6080808@domain.hid>
	<4C740201.5050606@domain.hid>
In-Reply-To: <4C740201.5050606@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] hostrt patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Btw, could you pick Wolfgang's host rt clock patch in your queue as
>>> well? I only have a few minor issues with it, which are no showstopper.
>>> The only thing to care of before merging this to mainline, is that no
>>> other arch does support this feature yet, so it is important to make it
>>> fully optional in -noarch, and Xenomai-wise also.
>>>
>>> We likely need some __IPIPE_FEATURE_* symbol to be defined in
>>> arch/x86/include/ipipe_base.h for this purpose, so that depending code
>>> could test for presence.
>> Will have a look.
> 
> Checked again: thanks to HAVE_IPIPE_HOSTRT, there should no need for any
> feature bit. Will build-check this once more tomorrow.
> 
> What issue did you see?

Well, I think other features are named IPIPE_FEATURE_BLAH... But I guess
that is a minor issue.

-- 
					    Gilles.

