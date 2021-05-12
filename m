Subject: Re: [PATCH] Enable retrieving of RTNET network packet timestamp OOB
 using recvmsg()
References: <10a7-609bd080-9-35a6e6c0@188333121>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <abdc3c8d-2bd2-8dc3-19e8-cb31cd8ad552@siemens.com>
Date: Wed, 12 May 2021 16:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <10a7-609bd080-9-35a6e6c0@188333121>
Content-Type: text/plain; charset="utf-8"
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 12.05.21 14:57, François Legal via Xenomai wrote:
> This patch enables retrieving, in realtime application, of RTNET enabled adapters packet timestamps.
> It uses the linux semantic SO_TIMESTAMPNS, and the linux code to put the timestamp in the control_msg structure.
> 

Thanks for the patch. Could you reformat according to kernel style
(checkpatch.pl)?

> I tested this patch with af_packet sockets only. UDP  & TCP might be a little bit trickier as many fragment/segments get reassembled in a single recvmsg. I believe the linux code I used to put the timestamps in the control structure should be OK though.

How does Linux resolve the case of stamping fragmented messages?

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

