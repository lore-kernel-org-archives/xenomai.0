References: <b709f916-7c1e-8adb-bae7-60ce388fc8fc@siemens.com>
 <5c284b6e-b5e4-0054-805e-af4f7c15ee04@xenomai.org>
 <2723c58b-7375-ee8d-9b34-6643b6569bf1@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e92cbf3e-c4e1-8539-0e3e-5211ded7f462@xenomai.org>
Date: Mon, 26 Feb 2018 19:03:07 +0100
MIME-Version: 1.0
In-Reply-To: <2723c58b-7375-ee8d-9b34-6643b6569bf1@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] lib/boilerplate: Prevent migration to
 secondary mode for __printout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>
Cc: "Hartmann, Wolfgang" <wolfgang.hartmann@siemens.com>

On 02/26/2018 06:45 PM, Jan Kiszka wrote:
> From: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>
> 
> Use the __RT versions of the stdio function calls to avoid migration to
> secondary mode. In case of ___panic, flush the printer before exiting to
> avoid losing messages.
> 
> Signed-off-by: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - handle early print via standard calls
> 
>  lib/boilerplate/ancillaries.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 

Merged, thanks.

-- 
Philippe.

