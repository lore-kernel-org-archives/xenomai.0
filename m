Message-ID: <58205D17.2080908@numalliance.com>
Date: Mon, 07 Nov 2016 11:53:11 +0100
From: =?ISO-8859-1?Q?St=E9phane_ancelot?= <sancelot@numalliance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] reading/writing files api
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

In realtime contexts, it is sometime needed either to log into files 
some data, or to upload/download a firmware .
This means that realtime context must dialog and exchange buffers with a 
non realtime process.
This process is in charge of opening/reading /writing file in the non 
realtime side.

Maybe some people have already implemented these kind of tasks.
Defining a common api / program in xenomai to permit this would be nice.
What do you think about it ?

Regards,
S.Ancelot

