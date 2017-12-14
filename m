References: <mailman.3.1513162802.24204.xenomai@xenomai.org>
From: JackLee <jacklee11@foxmail.com>
Message-ID: <670462c5-ab6d-3d27-225e-012f67dc5e53@foxmail.com>+BB7507C24109EFB3
Date: Thu, 14 Dec 2017 09:56:04 +0800
MIME-Version: 1.0
In-Reply-To: <mailman.3.1513162802.24204.xenomai@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Xenomai] Xenomai Digest, Vol 68, Issue 14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-request@xenomai.org


>> PPC64 is a non-trivial port to maintain (mostly regarding the
>> interrupt pipeline). However, the Xenomai user base for this
>> architecture has always been very small, not to say marginal.
>>
>> As part of the ongoing effort to fit the project to the resources, I
>> would suggest to drop support for the PowerPC64 architecture, in the
>> same terms than it just happened with Blackfin, i.e.
>>
>> - The I-pipe support for the ppc64 architecture would not be
>> maintained beyond kernel 4.9.51 (LTS).
>>
>> - ppc64 support would be marked as deprecated in the next releases of
>> the Xenomai 3.0.x series, then no more maintained from that point (not
>> even build tested). This code would be fully removed from the -next
>> branch leading to Xenomai 3.1.
>>
>> Please send any feedback before Jan 15, 2018.
> No objections from my side.
>
> Henning
>
>> Thanks,
>>
I think you can build some developer boards based on x86 and arm, especailly
tune the realtime drivers well, e.g. rtnet, rtcan. This can make some 
profit.
I can contact factories in China and help you deliver them.



