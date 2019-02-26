Subject: Re: Intel Turbo Mode
References: <CAPR3TAj=fvbOHCy2qXhdR9g=QBvq81LM89XLw6uTvqoHhgPayw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57ea6eb3-52a0-a29c-77b8-a5a4f8d24127@siemens.com>
Date: Tue, 26 Feb 2019 19:41:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAPR3TAj=fvbOHCy2qXhdR9g=QBvq81LM89XLw6uTvqoHhgPayw@mail.gmail.com>
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
To: cagnulein <cagnulein@gmail.com>, xenomai@xenomai.org

On 26.02.19 17:35, cagnulein via Xenomai wrote:
> Hi everybody,
>    i would like to give my contribution to this incredible project.
>   In these days i'm working on a Intel Atom E3930 (2 cores 1.3GHz with Turbo
> Mode to 1.8GHz) and Xenomai.
>   Everything working flawless, except the turbo mode.
>   Infact, in order to enabling the turbo mode, with the vanilla kernel, i
> have to enabling ACPI Processor causing high latency on Xenomai (over 350
> us).
> 
>   I've create a patch for the vanilla kernel, that allows to enabling the
> Turbo Mode without adding the ACPI Processor!
>   In this way i can have cpu at maximum speed with a deterministic and low
> latency (under 36 us!).
> 
>   Here you can find the patch. Maybe you can add it on ipipe?
> 

Thanks for your contribution! We can consider adding this, I would just like to 
double-check first if there aren't also patch-free ways today:

I always wanted to try out the runtime tunings described e.g. on 
https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/cpuidle 
to see if we could relax our build-time feature-exclusion set and rather do that 
tuning e.g. on Xenomai application startup.

Would you be interested in in playing with such an approach?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

