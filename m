Subject: Re: smokey's fork tests hangs with glibc 2.28+ ?
References: <c57ea289db8a425da4d09d89d0de5d96@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <76f0e9a2-f783-df4f-d736-4f0e246d44c2@siemens.com>
Date: Mon, 11 Mar 2019 14:50:25 +0100
MIME-Version: 1.0
In-Reply-To: <c57ea289db8a425da4d09d89d0de5d96@andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 11.03.19 14:40, Lange Norbert wrote:
> Well, swapping out glibc with 2.27 removes the issue, so it has been introduced afterwards,
> the current buildroot will use 2.28 so you should be able to build yourself a reproducer that way.
> I will also attach a prebuilt rootfs once the clean rebuild is done.

Ok, thanks for narrowing that further down.

I just realized that buster (Debian 10) will use 2.28 as well. Will try that 
baseline as well.

> 
> Unfortunately the smokey suite is not available with the Mercury core, might be easier to isolate that way.
> 
> In the future, maybe some battletested glibc versions could be recommended for xenomai?

Maintained distributions are generally a good choice. My plan is to define and 
test reference images via https://gitlab.denx.de/Xenomai/xenomai-images, but we 
are not there yet.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

