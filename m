Message-ID: <5541BFA1.40101@bmwedler.de>
Date: Thu, 30 Apr 2015 07:37:37 +0200
From: Registrierungen <regist@bmwedler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 3.0rc creating alchemy task in a shared object
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

i ve got a working xenomai application using alchemy tasks and try to 
outource funtionallity into a shared object.
If i try to create a thread (same code like in the application) in the 
shared object rt_create_task allways returns EEXISTS.
Name parameter change or set to NULL does not change anything.

Are there any side effects if i try to create alchemy tasks inside a 
shared object or are there any restrictions?

Regards
   Sascha




