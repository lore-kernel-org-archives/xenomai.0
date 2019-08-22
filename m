Subject: Re: affinity of main thread is bound to current core
References: <VI1PR05MB591718EB50E68F91B3DFD398F6AA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4211a9c2-957d-886d-da52-260a24a64632@siemens.com>
Date: Thu, 22 Aug 2019 16:51:57 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591718EB50E68F91B3DFD398F6AA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 21.08.19 14:12, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I use Xenomai master on ipipe-core-4.19.60-x86-5.
> I start out with an affinity mask of 0xF, in the function cobalt_init_2,  pthread_setschedparam will get called, after the syscall sc_cobalt_thread_setschedparam_ex the affinity mask will contain a single CPU (supposedly the current one).
> 
> All methods to control affinity are executed before this point (cmdline args, /proc/xenomai/affinity), so there is no working way to control it.
> 

Not sure I get the problem yet: "some-xenomai-app --cpu-affinity X" seems to 
work fine, so does setting /proc/xenomai/affinity. Can you describe more 
concretely what behaves unexpectedly, maybe with a test case?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

