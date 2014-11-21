Date: Fri, 21 Nov 2014 13:19:24 +0100
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20141121131924.C82CFFED@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] =?utf-8?q?T=5FCPU_macro?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello.

The T_CPU macro is probably missing parentheses around the cpu argument (IMHO):
#define T_CPU(cpu) (1 << (24 + (cpu & 7)))
should be:
#define T_CPU(cpu) (1 << (24 + ((cpu) & 7)))

It's located in the include/trank/native/task.h file.

Petr

