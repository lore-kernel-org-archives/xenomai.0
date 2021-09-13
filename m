Subject: Re: setup RTnet
References: <CAK6DXL1OLq6eTfnGp9AMsLVo664+tE2KO=_Uq+GVKpxPamcMxw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c2131a22-2fd6-94ef-6501-f7bf1e568598@siemens.com>
Date: Mon, 13 Sep 2021 11:58:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL1OLq6eTfnGp9AMsLVo664+tE2KO=_Uq+GVKpxPamcMxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Marco Barletta <barlettamarco8@gmail.com>, xenomai@xenomai.org

On 11.09.21 19:46, Marco Barletta via Xenomai wrote:
> Hi everyone;
> I was trying to setup RTnet but I found some problems. After removing
> non-rt e1000e module and loading rt one, when I run rtnet start I got the
> same output as
> https://www.mail-archive.com/xenomai@xenomai.org/msg18342.html. I know this
> is a known issue since the rt_e1000e doesn't work very well with i219-V
> Intel ethernet controller, and I checked out patches in
> https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html. Anyway I
> experienced some compile time issues with Xenomai 3.1, Linux 5.4.77. Do you
> have an updated version tested toward this kernel version? On gitlab I see
> the driver still doesn't support the controller.
> Thank you very much for the effort.
> 

Nothing recent is known to me.

As we know build up to 5.10, someone would have to set down again and
refresh / rebase the update. Best would be to split it into a vanilla
import of a specific mainline version + a patch on top that does the
needed adjustments. This time, I'll promise to look at things quicker.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

