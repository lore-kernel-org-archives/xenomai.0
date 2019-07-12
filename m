Subject: Re: [PATCH] prepare-kernal.sh: Add --copylinks option
References: <20190611105947.15478-1-johannes.kirchmair@sigmatek.at>
 <AM0PR08MB333013CCB8EB426A8595A85692F20@AM0PR08MB3330.eurprd08.prod.outlook.com>
 <e38df8f5-505e-9939-77f3-7da6d750d66e@siemens.com>
 <AM0PR08MB3330AE9F4B589B8D2097E96D92F20@AM0PR08MB3330.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <50e7888c-b5c8-5aa2-e9a6-6350e63ef870@siemens.com>
Date: Fri, 12 Jul 2019 13:46:46 +0200
MIME-Version: 1.0
In-Reply-To: <AM0PR08MB3330AE9F4B589B8D2097E96D92F20@AM0PR08MB3330.eurprd08.prod.outlook.com>
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
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12.07.19 13:43, Johannes Kirchmair wrote:
>> -----Ursprüngliche Nachricht-----
>> Von: Jan Kiszka <jan.kiszka@siemens.com>
>> Gesendet: Freitag, 12. Juli 2019 12:23
>> An: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>> xenomai@xenomai.org
>> Betreff: Re: [PATCH] prepare-kernal.sh: Add --copylinks option
>>
>> On 12.07.19 09:41, Johannes Kirchmair via Xenomai wrote:
>>> Hello everyone,
>>>
>>> just a ping to see if anyone has any remarks about this patch.
>>
>> Sorry, slipped through.
>>
>>>
>>> Best regards
>>> Johannes Kirchmair
>>>
>>> -----Ursprüngliche Nachricht-----
>>> Von: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>>> Gesendet: Dienstag, 11. Juni 2019 13:01
>>> An: xenomai@xenomai.org
>>> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>>> Betreff: [PATCH] prepare-kernal.sh: Add --copylinks option
>>>
>>> The prepare-kernal.sh script by default adds the xenomai kernel
>> components to the kernel source using soft links.
>>> If you move/remove the xenomai source or move the patched kernel
>> source to another workstation, you must change all this links or even replace
>> them by the actual files.
>>> To simplify the deployment of the patched kernel source to our coworkers,
>> we added the –copylinks option to the prepare-kernal.sh.
>>> The option causes the prepare-kernal.sh to copy the xenomai kernel
>> components instead of linking them.
>>> This makes it easy to move the patched kernel source to different
>> locations.
>>> Further, having the actual files in the kernel source makes the use of tools
>> like git grep that do not follow symbolic links by default more convenient.
>>> E.g. it gets harder to miss symbols searched with git grep by accident.
>>
>> What's the differentiation to using --outpatch
> 
> Actually missed that one or did not get it the right way. 
> Appling the --outpatch file actually does what we were trying to achieve.
> So we can drop this thread.
> Sorry for the disturbance. ;-)

No problem! If you feel like that feature is not optimally documented: We are
also taking doc patches. ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

