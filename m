Subject: Re: [PATCH 00/31] Update fec driver for xenomai 3 and linux kernel
 5.4 and add I.MX8 support
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
 <52cbdb82-5281-37fc-636d-5219950b77f0@siemens.com>
 <383c055b-6809-c073-ad67-0e5558c8c5b1@alstefgroup.com>
 <a7a3f0d6-18a9-f836-31ce-ab7dcfccd5ce@siemens.com>
 <87bl896ily.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44482a54-62ad-c547-8665-584475c7f471@siemens.com>
Date: Mon, 14 Jun 2021 09:41:10 +0200
MIME-Version: 1.0
In-Reply-To: <87bl896ily.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <philippe.gerum@ixblue.com>
Cc: =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?= <jean-baptiste.tredez@alstefgroup.com>, xenomai@xenomai.org

On 14.06.21 08:55, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 12.06.21 19:00, Jean-Baptiste Trédez wrote:
>>> Le 04/06/2021 à 11:14, Jan Kiszka a écrit :
>>>> On 11.05.21 18:05, Jean-Baptiste Trédez via Xenomai wrote:
>>>>> Update fec driver for xenomai 3 and linux kernel 5.4 and add I.MX8
>>>>> support
>>>>>
>>>>> Patch  1 to 27 : rtnet-mcast+vlan branch from Philippe Gerum with
>>>>> updated driver for 4.18.85 kernel
>>>> May I assume that submission of this branch has been coordinated between
>>>> you two, and Philippe considers them ready as well? Some patches lack
>>>> descriptions, and maybe I will find more things that should be adjusted
>>>> first. Will you address them then, Jean-Baptiste?
>>>>
>>>> Jan
>>>
>>> I rebased the work on fec driver with the rtnet-mcast+vlan branch on
>>> next, as suggested by Philippe, and added separated patch (patch 30 and
>>> 31) to show what i would like to change on previous work and added patch
>>> 28 and 29 to upgrade to 5.4.x kernels.
>>>
>>> I will address your findings on the fec driver and test it with a 5.4
>>> kernel on our target. I am not very familiar with the multicast and vlan
>>> work, if the work is not ready, i can submit the fec driver without the
>>> mcast+vlan work.
>>>
>>
>> Then it's better to split that, also the make the series smaller and,
>> thus, easier to digest for me.
>>
> 
> A bit of context to clarify:
> 
> I submitted the multicast and vlan series for inclusion in 3.x two years
> ago [1], but it could not make it into the 3.1 series due to bad timing
> (release date too close) and lack of time for the review process
> basically. Since then, it has been in use in lab configuration at
> iXblue, so far so good.
> 
> This series is a port to Xenomai 3.1 of a work Gilles did on top of
> 2.6.5 back in 2015. This original work is production software since
> then.
> 
> [1] https://xenomai.org/pipermail/xenomai/2019-March/040588.html
> 

We still have time for 3.2 inclusion, and I'm not against merging it. It
"just" takes someone to drive that, including the address possible
(though likely not fundamental) change requests.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

