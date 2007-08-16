Message-ID: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>
Date: Thu, 16 Aug 2007 14:04:37 +0200
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_79003_31896644.1187265877219"
Subject: [Xenomai-help] RTDM context_size question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_79003_31896644.1187265877219
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

When looking at the rtdm examples tut01-skeleton en tut02-skeleton, I have a
question about the context_size in the rtdm_device struct.

In tut01-skeleton-drv.c, the context_size = sizeof(buffer_t), in the other
example context_size = 0. Both drivers uses the
rtdm_safe_copy_to_user/rtdm_safe_copy_from_user functions to write/read data
from buffer_t(kernel space) to user_space. So I don't understand why the
context_size in tut02 is different than in tut01. Or is the context_size
only important if we open the driver several times from one or more
user_space programs?

Thanks in advance

Steven

------=_Part_79003_31896644.1187265877219
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br><br>When looking at the rtdm examples tut01-skeleton en tut02-skeleton, I have a question about the context_size in the rtdm_device struct.<br><br>In tut01-skeleton-drv.c, the context_size = sizeof(buffer_t), in the other example context_size = 0. Both drivers uses the rtdm_safe_copy_to_user/rtdm_safe_copy_from_user functions to write/read data from buffer_t(kernel space) to user_space. So I don&#39;t understand why the context_size in tut02 is different than in tut01. Or is the context_size only important if we open the driver several times from one or more user_space programs?
<br><br>Thanks in advance<br><br>Steven<br><br><br>

------=_Part_79003_31896644.1187265877219--

