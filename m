From: Edouard Tisserant <edouard.tisserant@gmail.com>
References: <91652cf8-9e03-50c0-bee0-06d0bc315a91@gmail.com>
 <11012cd3-f1fb-b326-b396-5a71649f01f6@siemens.com>
Message-ID: <4814c7e8-575d-58c2-f915-ddd9fa6f79c4@gmail.com>
Date: Mon, 17 Sep 2018 08:52:29 +0200
MIME-Version: 1.0
In-Reply-To: <11012cd3-f1fb-b326-b396-5a71649f01f6@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTSKB_SIZE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>



>> RTSKB_SIZE=1533 was having a nasty influence on RX ring
>> allocation/handling. With RTSKB_SIZE set to the next power of 2 (2048),
>> it works better. It might simply be another bug in rt_fec, but I stopped
>> searching for now.
>
> What does "better" mean? "Crashes less frequently"? ;)

Well... It comes from a pile of patch that was rotting in an archive
since 2014. To be honest, it is not clear why I had to do that back then
and I left no comment for my future self. As far as I remember, some Rx
frames data were corrupted or missing. I'll come back with a patch and
clear explanation once I'll have it tested with and without the patch,
and found the origins of the problem, if any.

>> Should RTSKB_SIZE be defined with KConfig, and then depend on what
>> driver is selected ?
>
> If there are good reasons for making the buffer larger here (that
> should be understood, though), we could make it a configurable, or
> select the maximum of all enabled drivers (though I don't think the
> latter is expressible via kconfig).

I also think that Kconfig will not let us do that. Still we can make it
configurable, and add some #if and #error in drivers that require some
special RTSKB_SIZE. Then it would refuse to build if RTSKB_SIZE isn't
set according to individual drivers requirement.

Edouard


