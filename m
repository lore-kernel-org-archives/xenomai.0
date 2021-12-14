Subject: Re: [RFC PATCH 2/2] kernelshark: shape blue hollow box to show OOB
 state of task
References: <20211214031537.14914-1-hongzhan.chen@intel.com>
 <20211214031537.14914-3-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d2948da4-7e34-5225-6f1d-7fabdf7b6174@siemens.com>
Date: Tue, 14 Dec 2021 07:40:16 +0100
MIME-Version: 1.0
In-Reply-To: <20211214031537.14914-3-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 14.12.21 04:15, Hongzhan Chen wrote:
> 1. store cobalt_switch_contexts event to data container.
> 2. show blue hollow box to mark out-of-band state under the
>    basedline of task plot according to cobalt_switch_context
>    events.
> 3. clickable cobalt_switch_context plugin shapes.
> 

How do I activate this? I have the plugin built and apparently loaded,
but I'm not seeing that new boxes in the CPU or task plots.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

