Subject: Re: smokey's fork tests hangs?
References: <930188d381964d3794e4204d7ef2a477@andritz.com>
 <11bb63cf-9719-0e72-2c97-dafdb3b54da8@siemens.com>
 <f89e0d85d9ad4c0c9fcd6b65967b2efe@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1bd89442-cfe3-c324-470d-41dac02d0546@siemens.com>
Date: Fri, 8 Mar 2019 14:59:21 +0100
MIME-Version: 1.0
In-Reply-To: <f89e0d85d9ad4c0c9fcd6b65967b2efe@andritz.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 08.03.19 14:47, Lange Norbert wrote:
> 
>>
>> Not reproducible here with stable/3.0.x or next, and with ipipe-x86-4.14.y.
>> What are your parameters?
> 
> Not entirely upstream, but based on ipipe-core-4.14.89-x86-2 and xenomai master,
> the difference is contained in the rt_igb driver, which is not even loaded.
> Defconfig is attached.
> 
> I mostly suspect glibc as the relevant difference, I am using
> glibc-2.28-69-g1e5c5303a522764d7e9d2302a60e4a32cdb902f1.
> 
> Looking at the strace the child process 1039 is stuck at FUTEX_WAIT_PRIVATE,
> Don’t really know how to tackle this.

Is this a regression? Then try bisecting the causing commit.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

