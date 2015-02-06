Message-ID: <54D4D409.2020708@control.lth.se>
Date: Fri, 06 Feb 2015 15:47:37 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Mixing linux and alchemy (cobalt) calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I have an application that need both realtime and linux sockets, am I correct in assuming that
withe the alchemy skin I could access them like

  socket(...           // Linux version
  __real_socket(...    // Linux version
  __cobalt_socket(...  // Alchemy/cobalt version

while under the cobalt skin, it would be:

  socket(...           // Alchemy/cobalt version
  __real_socket(...    // Linux version
  __cobalt_socket(...  // Alchemy/cobalt version


/Anders
-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


