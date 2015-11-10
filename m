Message-ID: <5641F09E.3040608@free.fr>
Date: Tue, 10 Nov 2015 14:26:54 +0100
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] panic macro interference with xerces api.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I don't know if there might be a  big impact, but I noticed, depending 
on the order we include headers , that
there was a panic macro interfering with xercesc api headers.

#include <alchemy/task.h>
#include <xercesc/dom/DOMException.hpp>


/usr/xenomai-3.0-igb/include/boilerplate/ancillaries.h:64:10: error: 
expected identifier before '__func__'
   __panic(__func__, __fmt, ##__args)
           ^
Regards,
Steph

