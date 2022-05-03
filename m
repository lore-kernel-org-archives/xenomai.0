Message-ID: <344ccd81-a8a6-4c8b-d1be-204d8514a4f7@tin.it>
Date: Tue, 3 May 2022 10:20:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] utils/net/rtnet.in: add delay during master
 configuration
Content-Language: it-IT
References: <7de1b93d-4feb-20a6-9204-6c8eddd0fa17@tin.it>
 <0247b98d-5768-96cb-3a87-2cc3e88e2d89@siemens.com>
 <bf1aa2ec-76a8-ebf7-b7db-49c478467c67@tin.it>
 <8b6bf0f637e18e708bb3e6a1bd1bf4019905e2ad.camel@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
In-Reply-To: <8b6bf0f637e18e708bb3e6a1bd1bf4019905e2ad.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Il 26/04/22 17:18, Bezdeka, Florian ha scritto:
> On Tue, 2022-04-26 at 16:24 +0200, Mauro S. wrote:
>> Hi Florian,
>>
>> thanks for your comments. See below mine.
>>
>> Il 23/04/22 19:26, Florian Bezdeka ha scritto:
>>> Hi all,
>>>
>>> some minor comments, see below:
> 
> [snip]
>>>>
>>>> +    The parameter -d allows to introduce a delay in seconds between the
>>>> +    "rtifconfig rtethX up" command and the TDMA start on the host
>>>> +    configured as master. Useful to avoid errors/card locks when the
>>>> +    RT NIC is slow to get the link up.
>>>>        The additional switch -v enables verbose output.
>>>>        The additional switch -c enables capturing mode to allow use of a
>>>> network
>>>>        analyzer such as Wireshark (if rtnet was built with --enable-rtcap).
>>>> @@ -76,6 +80,10 @@ submit_cfg() {
>>>>        master)
>>>>            $RTIFCONFIG rteth0 up $STATION_IP
>>>>
>>>> +        if [ -n "$UPDELAY" ]; then
>>>
>>> Checked with shellcheck? I would expect ${UPDELAY} here and below.
>>
>> In fact, among many (info) and (warning) messages regarding other lines,
>> shellcheck says about this row:
>>
>>     Line 84:
>>                     sleep $UPDELAY
>>                           ^-- SC2086 (info): Double quote to prevent
>> globbing and word splitting.
>>
>>     Did you mean: (apply this, apply all SC2086)
>>                     sleep "$UPDELAY"
>>
>> What should I do?
> 
> My understanding is that "${UPDELAY}" is the correct thing here.
> In case shellcheck reports more issues in the same file I would prefer
> two patches:
> 
> 1) Fixing shellcheck reportings
> 2) This one on top
> 
> But at the end it's the maintainers' decision.

Sorry for the delay.

Ok, I will do that.

Thanks.

-- 
Mauro S.

