Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
 <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
 <9cc5a0de-1db9-e46f-7aa8-30e41b1ac926@siemens.com>
 <f92ca27d1ba34380b47c0c451da4f61b@RCDC-MAIL09.corp.diehl.com>
 <925e50f4-8395-2a15-3654-73ea1f241f1c@siemens.com>
 <b4806aec7c5746bc83fa897b09ce7ab1@RCDC-MAIL09.corp.diehl.com>
 <d36eca04d68b4434bde75d9cfa8c1418@RCDC-MAIL09.corp.diehl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f7fc8190-afe3-872e-d7aa-dcabcd576a77@siemens.com>
Date: Tue, 3 Mar 2020 11:51:51 +0100
MIME-Version: 1.0
In-Reply-To: <d36eca04d68b4434bde75d9cfa8c1418@RCDC-MAIL09.corp.diehl.com>
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
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.03.20 11:44, Carsten EHRMANN wrote:
> Hi Jan,
> 
> after a few try and error I got the code compiled. When I try to start the executable I got the following error from rt_pipe_create(): -97
> 
> I use the function as follow: if(rt_pipe_create(&mControlPipe,aControlPipeName,P_MINOR_AUTO,2048) >= 0)
> 
> In the logfile there is no error from the kernel. Latency, Clock and Switch test have been ok.
> 
> Do you know what this mean? I haven't found anything .
> 

EAFNOSUPPORT - seems your kernel lacks support for the pipe or some 
module is missing. Make sure you have XENO_DRIVERS_RTIPC_XDDP and the 
xeno_rtipc.ko is loaded (if it's a module).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

