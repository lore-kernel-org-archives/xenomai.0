Message-ID: <52CEA753.8000800@espera.de>
Date: Thu, 09 Jan 2014 14:42:43 +0100
From: Andreas Schwark <schwark@espera.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] POSIX message queues
Reply-To: schwark@espera.de
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

we are working with Orocos-Toolchain on a PC with Lubuntu Version 12.04 
patched with Xenomai. For inter-process communication between Orocos 
processes we use POSIX messages queues. The communication works fine 
with less then 60 message queues. If we want to use more than 60 message 
quess, than we are not able to create more than 60 queues.  Can somebody 
tell me where we can setup the maximum number of queues?

Thank you in advance,
Andreas



