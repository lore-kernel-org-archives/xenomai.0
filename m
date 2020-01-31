Subject: Re: RTnet from userspace
References: <CAPnNZ0U1xhs91myD8gtD3CC_MdN-LW+9UX-r1V+XVwNGg8RMfQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <33ccf685-9959-9743-8bfc-efb0b88ffd23@siemens.com>
Date: Fri, 31 Jan 2020 11:44:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0U1xhs91myD8gtD3CC_MdN-LW+9UX-r1V+XVwNGg8RMfQ@mail.gmail.com>
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
To: Antoine Hoarau <antoine@flr.io>, Xenomai <xenomai@xenomai.org>

On 30.01.20 22:40, Antoine Hoarau via Xenomai wrote:
> Hi,
> I'm trying to run rtnet executables (ex: rtifconfig) from user-space.
> User is in the xenomai group and can run xenomai applications without
> sudo/being root.
> rtifconfig results in:  ioctl: Operation not permitted
> What would be the best/most linux way to only authorize the xenomai group
> to access those functions ?

The Xenomai group is mean to allow *applications* to use Xenomai. You 
are requesting an admin privilege. For that you need CAP_SYS_ADMIN, just 
like you need it to configure normal networking.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

