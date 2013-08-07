Message-ID: <52028C60.90405@xenomai.org>
Date: Wed, 07 Aug 2013 20:05:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1124806E0C09F04A992E69AE2EC7FA3C80A6B1@swexchange01.itk.local>
	<CADVgf9koTnR2AnnF3sOdpzFBN3j0TWbd8go_5c-=2MWs01cu4g@mail.gmail.com>
In-Reply-To: <CADVgf9koTnR2AnnF3sOdpzFBN3j0TWbd8go_5c-=2MWs01cu4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems with running Xenomai on Core i5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Fornero <mfornero.lists@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/07/2013 05:13 PM, Matthew Fornero wrote:
> On Wed, Aug 7, 2013 at 9:38 AM, Tobias Luksch
> <Tobias.Luksch@itk-engineering.de> wrote:
>> To me it looks like some power management feature of the CPU is kicking in. I
>> have disabled (hopefully) all relevant features in the BIOS (like EISS,
>> TurboBoost, Idle Modes, ...) and in the kernel (CPU frequency scaling, ...,
>> config file of me latest try is attached), /proc/cpuinfo always shows the same
>> frequency. Still I get the behavior described above.
> 
> Hi Tobias,
> 
> What you're describing sounds exactly like C1E kicking in-- there
> seems to be a latency penalty when cores exit C1E. This is usually not
> exposed in the BIOS power settings (we had to add it to our boards).
> Fortunately it can be controlled via MSR and takes effect immediately.
> There's a bit in MSR 0x1FC (MSR_IA32_POWER_CTL) that needs to be
> cleared. I *believe* it's bit 1, but can't remember. Note that I
> believe this MSR is defined per-core, so you'll need to toggle the MSR
> on all the cores that you want to disable C1E on (usually all of
> them).
> 
> A google search for MSR_IA32_POWER_CTL and C1E should be able to find
> some sort of documentation.
> 
> You should be able to tell if it's working using the built-in xenomai
> latency test. Run it on an idle (and otherwise well configured) system
> for 5-10 minutes and you should see a very noticable difference in
> scheduler latency with C1E on and off.

IIRC, the C1E can be enabled/disabled with Intel BIOS testing utilities:
http://biosbits.org/

-- 
                                                                Gilles.

