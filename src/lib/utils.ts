import { supabase } from './supabase';

export function escapeHTML(str: string | null | undefined): string {
  if (!str) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

export async function checkAdminRole(userId: string): Promise<boolean> {
  console.log('Checking admin role for userId:', userId);
  const { data, error } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', userId)
    .single();

  console.log('checkAdminRole result:', { data, error });

  if (error || !data) return false;
  return data.role === 'admin';
}
