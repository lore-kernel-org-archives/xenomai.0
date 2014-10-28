Message-ID: <544F6117.7070101@bmwedler.de>
Date: Tue, 28 Oct 2014 10:25:43 +0100
From: Registrierungen <regist@bmwedler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Using pipes in 3.0rc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

i try to switch with my working project from Xenomai 2.6 to 3.0rc 
Cobaltusing the native/alchemy skin.

Creating tasks,etc. seems to works fine.

If i try to open a pipe from the realtime taks using rt_pipe_create it 
returns with the error -88.
XDDP/rpc ist activted in th kernel.
  I used this Makefile config:

XENO_CONFIG := /usr/xenomai/bin/xeno-config
CFLAGS := $(shell $(XENO_CONFIG) --skin=alchemy --cflags)
LDFLAGS := $(shell $(XENO_CONFIG) --skin=alchemy --ldflags)
CC := $(shell $(XENO_CONFIG) --cc)

Has anything changed handling pipes in 3.0?

What exacliy this error means?

Thanks

   Sascha


