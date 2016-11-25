MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2016 17:03:48 -0500
From: andrija@stupar.com
Message-ID: <e91afecfce4b074fe8e8bcce5d868237@stupar.com>
Sender: andrija@stupar.com
Subject: [Xenomai] Migrating device drivers from RTLinux to Xenomai/Analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am wondering if any Xenomai users or admins/contributors can give me 
an idea of the scale of a project I am thinking of undertaking.

My university has PCs running RTLinux (on RedHat if I remember 
correctly) with custom-made data acquisition (DAQ) boards which are used 
to control some equipment and record back data in laboratory experiments 
for electrical engineering students. Now, those PCs are very old and 
failing regularly, and as I understand RTLinux has been effectively 
discontinued, so they want to replace them with something else.

They have found Xenomai as an attractive option, and I have been asked 
to write drivers for the DAQ boards (the boards connect as PCI cards).

As I understand, I would have to use Analogy to implement the drivers 
for real-time operation, however what is missing obviously is the actual 
device driver Analogy will talk to. Analogy as I can see comes with a 
bunch of drivers for commercial DAQ boards (from NI and so on), but I 
need to have my own since it is a custom board.

I have code for the DAQ board drivers (written in C) from RTLinux. Now I 
am familiar with driver basics but am no expert. The code seems 
straightforward enough.

How much of an effort would it be to port said drivers to 
Xenomai/Analogy, approximately? Is this relatively straightforward, or 
does it require writing from scratch?

Thanks a lot for any guidance on this issue.

Cheers,
Andrija Stupar
University of Toronto

