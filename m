Message-ID: <20100511154922.1435425ohdyyt08w@domain.hid>
Date: Tue, 11 May 2010 15:49:22 +0200
From: Michel He <michel.he@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] RT_TASK structure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,

       In Xenomai, I need an equivalent function of  
pthread_setspecific in order to register a key element associated to  
the RT_TASK. Is it possible to you (maintainers of Xenomai core) to  
add an extra integer type (let's say int user_specific_data inside the  
struct rt_task) in the RT_TASK structure and then add functions  
similar to pthread_setspecific and pthread_getspecific to allow user  
to write and get this integer value (associated to RT_TASK) ?


Thank you very much



