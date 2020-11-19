Subject: Re: socket: Address family not supported by protocol
References: <CAFZ-hKizgaCMi5=P-WifrfiBSLNdrOs_TAke++MVCi2j=xYfiQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0b9b2349-1a10-db7d-5c4a-1f58add978b3@siemens.com>
Date: Thu, 19 Nov 2020 08:08:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFZ-hKizgaCMi5=P-WifrfiBSLNdrOs_TAke++MVCi2j=xYfiQ@mail.gmail.com>
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
To: Leandro Bucci <guestleandro11@gmail.com>, xenomai@xenomai.org

On 18.11.20 22:51, Leandro Bucci via Xenomai wrote:
> Hello to all. I have installed xenomai 3.1 on the raspberry pi4.
> The latency and cyclictest examples work great. But examples like
> iddp-label and xddp-echo don't work.
> I get this error:
> socket: Address family not supported by protocol
> how can i solve this problem? maybe i need to load the related kernel
> modules? If yes, how do you do it? sorry but I'm a beginner.
> 

Did you configure these features into your kernel
(CONFIG_XENO_DRIVERS_RTIPC_IDDP, CONFIG_XENO_DRIVERS_RTIPC_XDDP)? Did
you load the related modules if they were configured as modules
(xeno_rtipc-{xddp,iddp}.ko)?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

