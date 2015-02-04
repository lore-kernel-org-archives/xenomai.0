Message-ID: <54D21BA2.2020708@xenomai.org>
Date: Wed, 04 Feb 2015 14:16:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1928985868.3780.1423040133670.JavaMail.zimbra@wandercraft.eu>
 <54D1E2AA.40000@xenomai.org>
 <2118665101.4111.1423048074765.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <2118665101.4111.1423048074765.JavaMail.zimbra@wandercraft.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3 - no skin detected in program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On 02/04/2015 12:07 PM, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
>> De: "Philippe Gerum" <rpm@xenomai.org>
>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>, xenomai@xenomai.org
>> Envoyé: Mercredi 4 Février 2015 10:13:14
>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
> 
>> On 02/04/2015 09:55 AM, Huy Cong Vu wrote:
>>> Hello everyone,
>>> I recently try to run an application compiled in native skin of Xenomai 3. When
>>> trying to run the binary, these line appeared:
>>> WARNING: [main] no skin detected in program
>>> BUG: [main] initialization failed, EINVAL
>>> I know that this is a cooperplate_init() warning when trying to initialize
>>> native skin, but I don't understand the reason why:
>>> if (pvlist_empty(&skins)){
>>> warning("no skin detected in program");
>>> ret = -EINVAL;
>>> goto fail;
>>> }
>>
>> It seems that your application was not linked against libalchemy.so.
>> When API libraries are properly linked in, internal constructor routines
>> populate this list. POSIX support is built-in within the Cobalt
>> interface, so it won't appear here though.
>>
>> You may want to check this with ldd.
>>
> 
> Indeed, I'm working on the linking option to find out why, it seems that -ffunctions-sections and -Wl,--gc-sections hides the -lalchemy flag so I removed it. 
> 
>>> In my main(), there are still native API calls:
>>> rt_print_auto_init(1);
>>> rt_task_spawn(...);
>>> rt_task_join(...);
>>> rt_task_delete(...);
>>> with mlockall also just to make sure, even I know that is pre-initialize since
>>> Xenomai 2.6.
>>> I have xenomai-3-next patched on linux-3.14.17, here are my compilation flags:
>>> cflags:
>>> xeno-config --alchemy --cflags
>>> xeno-config --rtdm --cflags
>>> ldflags:
>>> xeno-config --alchemy --ldflags
>>> xeno-config --rtdm --ldflags
>>
>> You should not mention --rtdm for userland apps, this is useless for
>> Xenomai 3. This has been kept for compatibility purpose with existing
>> application Makefiles targeting Xenomai 2.x.
>>
>  
> But what if one of my static library calls from rtdm? Which flags should I add then if I can't use xeno-config --rtdm anymore?
> 

None, it's available as a built-in feature of the POSIX API over cobalt.

-- 
Philippe.

