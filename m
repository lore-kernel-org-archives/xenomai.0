From: Umair Ali <ali.umair@tut.fi>
Date: Tue, 15 Dec 2015 11:28:02 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A716140@mb2010-1.intra.tut.fi>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Switching to secondary mode despite of use of mmap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am reading a file of size 600 MB using the mmap function and mlockall(). =
My question is that is it possible that mmap has not loaded whole file in t=
he memory and if the whole file is not loaded then is it changing to second=
ary mode while reading the file. The size of system heap is 256KB in the me=
nuconfig for the compiling kernel. If the problem, i think, i have is true =
then how i can load the such big files using mmap. The output of slackspot =
is attached with this email. My system specs are
Memory 3.1GiB and processor is intel P4 3.2GHz x 2.

Thanks and regards
Ali
-------------- next part --------------
A non-text attachment was scrubbed...
Name: slackspot_output
Type: application/octet-stream
Size: 20870 bytes
Desc: slackspot_output
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151215/81aeb313/at=
tachment.obj>
