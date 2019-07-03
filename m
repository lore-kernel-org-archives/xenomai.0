Subject: Re: fail clocktest -C CLOCK_HOST_REALTIME
References: <fa7df77f-23f9-4cc2-cc2e-aa1f9d4010bc@iit.it>
 <b2696236-4ba3-c9b0-a22f-9210f83cd163@siemens.com>
 <bdab9339-22bb-1da3-8453-e79bfeb204b2@iit.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <611371d4-437c-b269-e8e6-4081174b247b@siemens.com>
Date: Wed, 3 Jul 2019 20:27:00 +0200
MIME-Version: 1.0
In-Reply-To: <bdab9339-22bb-1da3-8453-e79bfeb204b2@iit.it>
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
To: alessio margan <alessio.margan@iit.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.07.19 20:22, alessio margan via Xenomai wrote:
> Hi,
> 
> now I have the proper config
> 
> (base) embedded@com-exp:/usr/src/linux-4.14.89-xeno-stable-v3.0.x$ cat .config | 
> grep HOSTRT
> CONFIG_XENO_OPT_HOSTRT=y
> CONFIG_IPIPE_HAVE_HOSTRT=y
> 
> .. it 's compiling, I let you know

My own test already succeed. Waiting for your ok, then I'll role out 4.14.132 
with this fixed. And 4.19.57 as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

