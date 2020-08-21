Subject: Re: Strange switching [threadname] to secondary mode after exception
 #0 in kernel-space at 0x80272444
References: <1174-5f3e7f00-1-37e14c00@201456977>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7a487933-dd50-6ee9-cd5f-6d99bc5b3c76@siemens.com>
Date: Fri, 21 Aug 2020 20:04:41 +0200
MIME-Version: 1.0
In-Reply-To: <1174-5f3e7f00-1-37e14c00@201456977>
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

On 20.08.20 15:46, François Legal via Xenomai wrote:
> Using RTNet with multiple interfaces, xenomai 3.1 with linux 4.4
> Whenever a posix RT thread calls recvmsg (), I get this error.
> 
> I could track this down to line 422 in udp.c :     msg = rtnet_get_arg(fd, &_msg, u_msg, sizeof(_msg));
> 
> If I disassemble the kernel, the failing instruction (at 0x80272444) is a nop in arm_copy_from_user
> Am I doing anything wrong ?

Maybe you are passing an invalid pointer to recvmsg, directly or in its
message structures. That would cause an exception which is fixed up but
also reported. Do you get an error in return?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

