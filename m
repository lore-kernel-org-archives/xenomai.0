From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B0B2EA.8000602@xenomai.org>
Date: Thu, 23 Jul 2015 11:24:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_print_auto_init()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Hi Jan,

Do you still have a use case for calling rt_print_auto_init(false) or
not calling rt_print_auto_init(true) from libcobalt's bootstrap code?

-- 
Philippe.

