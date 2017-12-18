From: Bastien COUNILH <bcounilh@numalliance.com>
Message-ID: <39ebca6b-d5b4-4a70-4a81-dcf11f0393e1@numalliance.com>
Date: Mon, 18 Dec 2017 10:38:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Subject: [Xenomai] Compilation flags to chose mercury API over cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

I am programming an application that runs in the secondary zone, 
communicating with a primary zone application.
(Briefly , in the primary zone , i do data acquisition that I write in a 
shared memory. When i'm done writing data, i send a signal to my 
seondary zone program through a pipe to start its data analysis).

When it recieves the pipe signal, my function launches a series of 
calculation and verifications.
As it is not necessary done in a precise sequence, i decided to run the 
calculcations and the verification in parallel threads. It allows to 
gain execution time on the heavy calculations, but also to shut the 
program down faster if an error is returned by my data verification.

My problem is :
- I use the function pthread_create that is defined both in linux 
standard library and Cobalt core. These threads have to be created in 
the secondary zone. Is there a compilation flag that will allow me to 
use the regular ptrhead functions ratehr than Xenomai API ones ?


