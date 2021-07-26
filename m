Subject: Re: Analogy usage
References: <b6b70b3ef32940ac783748d10d5a91b2@rtxi.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <591b95a6-d81e-0f87-5d36-1af5d05e0688@siemens.com>
Date: Mon, 26 Jul 2021 07:37:14 +0200
MIME-Version: 1.0
In-Reply-To: <b6b70b3ef32940ac783748d10d5a91b2@rtxi.org>
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
To: ivan@rtxi.org, xenomai@xenomai.org

On 23.07.21 21:58, Ivan F. Valerio via Xenomai wrote:
> Hi everyone,
> 
> My name is Ivan and I am the current (new) maintainer for the Real-Time
> eXperiment
> Interface (RTXI). This is an application that uses Xenomai to provide
> real-time
> performance for experimental setups requiring deterministic control. A
> number
> of laboratories both here in the United States and abroad use RTXI for
> their
> biological experiments. RTXI uses the Analogy modules in order to interface
> with a variety DAQ cards. This has allowed easy adoption of RTXI as it
> provides
> compatibility among a wide range of DAQ cards out of the box.
> 
> I am new to the mailing list and while researching came across your
> discussion to
> discontinue Analogy. Removing Analogy would undoubtedly have an impact
> on all
> laboratories who use RTXI for their setups. What are the current plans for
> Analogy? What issues can I assist with to improve the state of this module?
> 

Thanks for you offer! It's great to learn about usage this way and also
to hear that you would like to help improving the situation.

As I explained in [1], we need at least some basic regular test
infrastructure. The other thing is to understand how Analogy is used:
with all its features or with specific aspects only (like Peter said he
is only using own, out-of-tree drivers with the framework)? The work
should focus on that first.

Jan

[1] https://xenomai.org/pipermail/xenomai/2021-July/045875.html

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

